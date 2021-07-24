package com.example.plugins

import freemarker.cache.*
import io.ktor.freemarker.*
import io.ktor.application.*
import io.ktor.response.*
import io.ktor.routing.*

fun Application.configureTemplating() {
    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
    }

    routing {
        get("/html-freemarker") {
            call.respond(FreeMarkerContent("templates/index.ftl", mapOf("data" to IndexData(listOf(1, 2, 3))), ""))
        }
    }
}
data class IndexData(val items: List<Int>)
