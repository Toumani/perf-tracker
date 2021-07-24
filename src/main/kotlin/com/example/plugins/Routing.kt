package com.example.plugins

import io.ktor.routing.*
import io.ktor.application.*
import io.ktor.freemarker.*
import io.ktor.response.*

fun Application.configureRouting() {

    routing {
        get("/") {
            call.respond(FreeMarkerContent("index.ftl", mapOf("loginFailed" to false), ""))
        }
    }
}
