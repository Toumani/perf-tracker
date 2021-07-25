package com.example.plugins

import com.example.model.User
import com.example.repository.Users
import io.ktor.auth.*
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.request.*
import io.ktor.routing.*
import io.ktor.sessions.*
import org.jetbrains.exposed.sql.and
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.transactions.transaction

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
        get("/logout") {
            call.sessions.clear<User>()
            call.respondRedirect("/")
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