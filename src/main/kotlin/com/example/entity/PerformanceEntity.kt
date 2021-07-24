package com.example.entity

import com.example.repository.Performances
import org.jetbrains.exposed.dao.EntityID
import org.jetbrains.exposed.dao.UUIDEntity
import org.jetbrains.exposed.dao.UUIDEntityClass
import java.util.*

class PerformanceEntity(uuid: EntityID<UUID>) : UUIDEntity(uuid) {
    companion object : UUIDEntityClass<PerformanceEntity>(Performances)

    var date by Performances.date
    var path by Performances.path
    var duration by Performances.duration
    var distance by Performances.distance
    var userId by UserEntity referencedOn Performances.userId
}