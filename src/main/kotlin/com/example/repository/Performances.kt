package com.example.repository

import org.jetbrains.exposed.dao.UUIDTable

object Performances : UUIDTable("performances") {
    val date = date("date_performed")
    val path = varchar("path", 255)
    val duration = long("duration") // millis
    val distance = integer("distance") // meter

    val userId = reference("user_id", Users)
}