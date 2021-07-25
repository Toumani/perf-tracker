package com.example.model

import org.joda.time.Duration
import org.joda.time.LocalDate
import java.time.format.DateTimeFormatter

data class Performance(
    val date: LocalDate,
    val path: String,
    val duration: Duration,
    val distance: Int, // distance in metres
) {
    val speedKmPerHour = (distance.toFloat()/1_000f)/duration.standardSeconds.toFloat()*3600
    val speedMetresPerSecond = distance.toFloat()/duration.standardSeconds.toFloat()
    val durationSeconds = duration.standardSeconds
    val formattedDate: String = date.toString("d/M/y")
    val formattedDuration: String =
        java.time.LocalTime.MIDNIGHT
            .plus(java.time.Duration.ofMillis(duration.millis))
            .format(DateTimeFormatter.ofPattern("H:mm:ss"))
}