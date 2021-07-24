package com.example.model

import java.time.Duration
import java.time.LocalDate

data class Performance(
    val date: LocalDate,
    val path: String,
    val duration: Duration,
    val distance: Float, // distance in metres
)