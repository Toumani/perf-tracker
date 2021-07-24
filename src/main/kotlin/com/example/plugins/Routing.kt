package com.example.plugins

import com.example.entity.UserEntity
import com.example.model.Performance
import com.example.model.User
import com.example.repository.Performances
import com.example.repository.Users
import io.ktor.routing.*
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.freemarker.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.sessions.*
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.transactions.transaction
import org.joda.time.DateTime
import org.joda.time.Duration

fun Application.configureRouting() {

    routing {
        static("assets") {
            resources("css")
            resources("js")
        }
        get("/") {
            if (call.sessions.get("user_session") == null)
                call.respondRedirect("/login")
            else
                call.respondRedirect("/summary")
        }
        get("/login") {
            val failure = call.parameters["failure"]?.equals("true") ?: false
            call.respond(FreeMarkerContent("login.ftl", mapOf("loginFailed" to failure), ""))
        }
        authenticate("auth-session") {
            get("/summary") {
                val user = call.sessions.get("user_session") as User
                lateinit var performances: List<Performance>
                transaction {
                    performances = (Users innerJoin  Performances).select { Users.id eq Performances.userId }.map {
                        Performance(
                            date = it[Performances.date].toLocalDate(),
                            path = it[Performances.path],
                            duration = Duration.millis(it[Performances.duration]),
                            distance = it[Performances.distance]
                        )
                    }
                }
                call.respond(FreeMarkerContent("summary.ftl", mapOf(
                    "user" to user,
                    "performances" to performances
                ), ""))
            }
            get("/new") {
                call.respond(FreeMarkerContent("new_performance.ftl", mapOf("user" to call.sessions.get("user_session"))))
            }
            post("/new") {
                val params = call.receiveParameters()
                val dateParam = params["date"] ?: return@post call.respond(HttpStatusCode.BadRequest)
                val pathParam = params["path"] ?: return@post call.respond(HttpStatusCode.BadRequest)
                val distanceParam = params["distance"] ?: return@post call.respond(HttpStatusCode.BadRequest)
                val hoursParam = params["hours"] ?: return@post call.respond(HttpStatusCode.BadRequest)
                val minuteParam = params["minutes"] ?: return@post call.respond(HttpStatusCode.BadRequest)
                val secondsParam = params["seconds"] ?: return@post call.respond(HttpStatusCode.BadRequest)

                try {
                    transaction {
                        val user = call.sessions.get("user_session") as User
                        val userEntity = Users.select { Users.name eq user.username }.map {
                            UserEntity(
                                id = it[Users.id]
                            )
                        }.first()
                        Performances.insert {
                            it[date] = DateTime.parse(dateParam) // if date is not well formatted, a bad request response is sent in the catch block
                            it[path] = pathParam
                            it[distance] = distanceParam.toFloat().toInt() // if distance is not a valid number, a bad request response is sent in the catch block
                            it[duration] = (hoursParam.toInt()*3600 + minuteParam.toInt()*60 + secondsParam.toInt()).toLong() * 1000

                            it[userId] = userEntity.id
                        }
                    }
                    call.respondRedirect("/summary")
                } catch (e: Exception) {
                    call.respond(HttpStatusCode.BadRequest)
                }
            }
            get("/logout") {
                call.sessions.clear<User>()
                call.respondRedirect("/")
            }
        }
    }
}
