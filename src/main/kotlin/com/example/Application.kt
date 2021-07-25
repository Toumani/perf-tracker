package com.example

import io.ktor.server.engine.*
import io.ktor.server.netty.*
import com.example.plugins.*
import com.example.repository.Performances
import com.example.repository.Users
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction

fun main() {
    embeddedServer(Netty, port = if (System.getenv("PORT").isNotEmpty()) { System.getenv("PORT").toInt() } else { 8080 }, host = "0.0.0.0") {
        configureSecurity()
        configureRouting()
        configureTemplating()
        initDB()
    }.start(wait = true)
}

fun initDB() {
    val dbUser = System.getenv("PERF_TRACKER_DB_USER")?:""
    val dbPass = System.getenv("PERF_TRACKER_DB_PASS")?:""
    val dbPort = System.getenv("PERF_TRACKER_DB_PORT")?:"5432"
    val dbName = System.getenv("PERF_TRACKER_DB_NAME")?:"perf_tracker"
    val dbHost = System.getenv("PERF_TRACKER_DB_HOST")?:"localhost"

    Database.connect(
        "jdbc:postgresql://$dbHost:$dbPort/$dbName",
        "org.postgresql.Driver",
        user = dbUser,
        password = dbPass
    )

    transaction {
        SchemaUtils.create(Users, Performances)
    }
}
