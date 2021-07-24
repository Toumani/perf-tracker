package com.example.model

import org.joda.time.Duration
import org.joda.time.LocalDate

data class Performance(
    val date: LocalDate,
    val path: String,
    val duration: Duration,
    val distance: Int, // distance in metres
)