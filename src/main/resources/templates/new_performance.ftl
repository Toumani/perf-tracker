<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.84.0">
    <title>Perf tracker - Summary</title>

    <!-- <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/dashboard/"> -->


    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .username {
            color: lightgrey;
            display: block;
            padding: .5rem 1rem;
            border-right: 1px solid lightgray;
        }
    </style>

    <!-- Custom styles for this template -->
    <link href="/assets/summary.css" rel="stylesheet">
</head>
<body>

<header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="/">Perf tracker</a>
    <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse"
            data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false"
            aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <#--  <input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search">-->
    <div class="navbar-nav" style="flex-direction: row">
        <div class="nav-item text-nowrap">
            <span class="username">${user.username}</span>
        </div>
        <div class="nav-item text-nowrap">
            <a class="nav-link px-3" href="/logout">Sign out</a>
        </div>
    </div>
</header>

<div class="container-fluid">
    <div class="row">
        <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="#">
                            <span data-feather="home"></span>
                            Summary
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <span data-feather="file"></span>
                            New performance
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">New performance</h1>
            </div>

            <form action="/new" method="post">
                <div class="mb-3">
                    <label for="date" class="form-label">Performance date</label>
                    <input type="date" class="form-control" id="date" name="date" required <#--aria-describedby="emailHelp"-->>
<#--                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>-->
                    <div class="invalid-feedback">Please, enter a date</div>
                </div>
                <div class="mb-3">
                    <label for="path" class="form-label">Path</label>
                    <input type="text" class="form-control" id="path" name="path">
                </div>
                <div class="mb-3">
                    <label for="distance" class="form-label">Distance in meters</label>
                    <input type="tel" class="form-control" id="distance" name="distance" required onkeyup="validateDistance()">
                    <div class="invalid-feedback">Please, enter a distance</div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Duration</label>
                    <div class="row">
                        <div class="col input-group">
                            <input type="tel" class="form-control" id="hours" name="hours" placeholder="Hours" value="0" aria-valuemin="0" required onkeyup="validateDuration()">
                            <div class="input-group-text">H</div>
                        </div>
                        <div class="col input-group">
                            <input type="tel" class="form-control" id="minutes" name="minutes" placeholder="Minutes" value="0" aria-valuemin="0" aria-valuemax="59" required onkeyup="validateDuration()">
                            <div class="input-group-text">m</div>
                        </div>
                        <div class="col input-group">
                            <input type="tel" class="form-control" id="seconds" name="seconds" placeholder="Seconds" value="1" aria-valuemin="0" aria-valuemax="59" required onkeyup="validateDuration()">
                            <div class="input-group-text">s</div>
                        </div>
                    </div>
                </div>
                <button type="reset" class="btn btn-secondary">Reset</button>
                <button type="submit" class="btn btn-primary" id="submit-btn" disabled>Save</button>
            </form>
        </main>
    </div>
</div>
<!-- <script src="../assets/dist/js/bootstrap.bundle.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js"
        integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"
        integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha"
        crossorigin="anonymous"></script>
<script>
    (function () {
        'use strict'

    })()

    const distance = document.getElementById('distance')
    const hours = document.getElementById('hours')
    const minutes = document.getElementById('minutes')
    const seconds = document.getElementById('seconds')
    const submitBtn = document.getElementById('submit-btn')

    const validateDistance = () => {
        let isFormValid = true
        if (isNaN(parseInt(distance.value)) || parseInt(distance.value) <= 0) {
            isFormValid = false
            // color distance in red
        }
        submitBtn.disabled = !isFormValid
    }

    const validateDuration = () => {
        let isFormValid = true
        if (isNaN(hours.value) || parseInt(hours.value) < 0) {
            isFormValid = false
            // color hours input in red
        }
        if (isNaN(minutes.value) || parseInt(minutes.value) < 0 || parseInt(minutes.value) > 59) {
            isFormValid = false
            // color minutes input in red
        }
        if (isNaN(seconds.value) || parseInt(seconds.value) < 0 || parseInt(seconds.value) > 59) {
            isFormValid = false
            // color seconds input in red
        }
        if (isFormValid) {
            if (isNaN(parseInt(hours.value) + parseInt(minutes.value) + parseInt(seconds.value)) ||
                0 === parseInt(hours.value) + parseInt(minutes.value) + parseInt(seconds.value))
                isFormValid = false
        }
        submitBtn.disabled = !isFormValid
    }
</script>
</body>
</html>
