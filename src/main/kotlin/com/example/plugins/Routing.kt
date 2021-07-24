package com.example.plugins

import io.ktor.routing.*
import io.ktor.application.*
import io.ktor.freemarker.*
import io.ktor.response.*
import io.ktor.sessions.*

fun Application.configureRouting() {

    routing {
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
    }
}
