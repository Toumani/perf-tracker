package com.example.plugins

import io.ktor.auth.*
import io.ktor.application.*
import io.ktor.freemarker.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.request.*
import io.ktor.routing.*
import io.ktor.sessions.*

data class UserSession(val id: String, val password: String) : Principal

fun Application.configureSecurity() {
    install(Sessions) {
        cookie<UserSession>("user_session")
    }
    install(Authentication) {
        session<UserSession>("auth-session") {
            validate { session ->
                if(session.id == session.password) {
                    session
                } else {
                    null
                }
            }
            challenge {
                call.respondRedirect("/login?failure=true")
            }
        }
    }

    routing {
        post("/login") {
            val params = call.receiveParameters()
            val userName = params["username"] ?: return@post call.respond(HttpStatusCode.BadRequest)
            val password = params["password"] ?: return@post call.respond(HttpStatusCode.BadRequest)

            call.sessions.set(UserSession(userName, password))
            call.respondRedirect("/summary")
        }
        authenticate("auth-session") {
            get("/summary") {
                call.respond(FreeMarkerContent("summary.ftl", mapOf("user" to call.sessions.get("user_session")), ""))
            }
            get("/logout") {
                call.sessions.clear<UserSession>()
                call.respondRedirect("/")
            }
        }
    }
}
