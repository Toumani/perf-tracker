package com.example.plugins

import com.example.model.Performance
import com.example.model.User
import com.example.repository.Performances
import com.example.repository.Users
import io.ktor.routing.*
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.freemarker.*
import io.ktor.http.content.*
import io.ktor.response.*
import io.ktor.sessions.*
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.transactions.transaction

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
                            duration = org.joda.time.Duration.millis(it[Performances.duration]),
                            distance = it[Performances.distance]
                        )
                    }
                }
                call.respond(FreeMarkerContent("summary.ftl", mapOf(
                    "user" to user,
                    "performances" to performances
                ), ""))
            }
            get("/logout") {
                call.sessions.clear<User>()
                call.respondRedirect("/")
            }
        }
    }
}
