package com.example.repository

import org.jetbrains.exposed.dao.IntIdTable

object Users : IntIdTable("users") {
    val name = varchar("name", 255)
    val password = varchar("password", 255)
}