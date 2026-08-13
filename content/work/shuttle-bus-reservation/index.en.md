---
title: "Shuttle Bus Reservation System"
date: 2024-04-01
description: "An assigned-seat reservation system for the shuttle bus operated at Kansai University's Takatsuki Campus."
tags: ["Docker", "Nginx", "Python", "Flask", "Jinja2"]
showDate: false
showReadingTime: false
showWordCount: false
---

**Period:** 2023–2024

I developed a reservation system for the shuttle bus operated at Kansai University's Takatsuki Campus.

## Background

The university had not previously operated a shuttle service. A reservation system was therefore developed alongside the launch of the new service. The system allows students to reserve a service and seat through a web application and authenticate with their student ID cards when boarding.

## System

The system manages 20 seats on each of four buses. Students can select a service and reserve a seat through the web application. Reservation data is managed by a Flask API and database running on an on-premises server.

Both the web application and the Raspberry Pi-based authentication devices installed on the buses retrieve reservation data through the Flask API. Each device compares the information read from a student ID card with the reservation data, displays whether the student is eligible to board, and records the completed boarding in the database.

An administrative interface also allows staff to review and manage reservation and boarding information, providing centralized oversight of shuttle usage.

## Card Reader

I built a custom authentication device incorporating an NFC reader, a Raspberry Pi, and a display. Students can verify their reservations by tapping their ID cards, making the boarding process more efficient.

![Custom-built student ID card reader](student-id-card-reader.jpg "Custom-built student ID card reader")

## Development

I built the on-premises server infrastructure for the system and performed the on-site setup and validation.

![Working overnight at the university while building the on-premises server infrastructure](overnight-server-setup.jpg "Working overnight at the university while building the on-premises server infrastructure")

## Technology

Docker / Nginx / Python / Flask / Jinja2
