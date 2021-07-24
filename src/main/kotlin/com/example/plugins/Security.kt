package com.example.plugins

import com.example.model.Performance
import com.example.model.User
import com.example.repository.Users
import io.ktor.auth.*
import io.ktor.application.*
import io.ktor.freemarker.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.request.*
import io.ktor.routing.*
import io.ktor.sessions.*
import org.jetbrains.exposed.sql.and
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.transactions.transaction
import java.time.Duration
import java.time.LocalDate
import java.time.Month

fun Application.configureSecurity() {
    install(Sessions) {
        cookie<User>("user_session")
    }
    install(Authentication) {
        session<User>("auth-session") {
            validate { session -> session }
            challenge {
                call.respondRedirect("/login")
            }
        }
    }

    routing {
        post("/login") {
            val params = call.receiveParameters()
            val userName = params["username"] ?: return@post call.respond(HttpStatusCode.BadRequest)
            val password = params["password"] ?: return@post call.respond(HttpStatusCode.BadRequest)

            val user = loginUser(userName, password)
            if (user != null) {
                call.sessions.set(user)
                call.respondRedirect("/summary")
            }
            else {
                call.respondRedirect("/login?failure=true")
            }
        }
        authenticate("auth-session") {
            get("/summary") {
                val performances = listOf(
                    Performance(LocalDate.of(2021, Month.JUNE, 29), "Bouskoura forest",  Duration.ofSeconds(60*10 + 22), 1_230f),
                    Performance(LocalDate.of(2021, Month.JULY, 1),  "Bouskoura forest", Duration.ofSeconds(60*12 + 13), 1_540f),
                    Performance(LocalDate.of(2021, Month.JULY, 13), "Bouskoura forest",  Duration.ofSeconds(60*15 + 27), 1_600f),
                    Performance(LocalDate.of(2021, Month.JULY, 15), "Bouskoura forest",  Duration.ofSeconds(60*17 + 12), 3_000f),
                    Performance(LocalDate.of(2021, Month.JULY, 17), "Road to Casa",  Duration.ofSeconds(60*19 + 49), 3_000f),
                    Performance(LocalDate.of(2021, Month.JULY, 21), "Road to Casa",  Duration.ofSeconds(60*19 + 40), 3_000f),
                    Performance(LocalDate.of(2021, Month.JULY, 23), "Road to Casa",  Duration.ofSeconds(60*18 + 30), 3_000f)
                )
                call.respond(FreeMarkerContent("summary.ftl", mapOf(
                    "user" to call.sessions.get("user_session"),
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

fun loginUser(username: String, password: String): User? {
     lateinit var users: List<User>
    transaction {
        users = Users.select { Users.name eq username and (Users.password eq password) }.map {
            User(
                username = it[Users.name]
            )
        }
    }
    return users.firstOrNull()
}