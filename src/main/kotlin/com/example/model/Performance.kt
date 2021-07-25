package com.example.model

import org.joda.time.Duration
import org.joda.time.LocalDate

data class Performance(
    val date: LocalDate,
    val path: String,
    val duration: Long,
    val distance: Int, // distance in metres
) {
    val speed = (distance*1_000).toFloat()/duration.toFloat()*3_600
}