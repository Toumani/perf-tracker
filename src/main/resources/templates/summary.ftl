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
    <div  id="app">
        <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
            <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3" href="/">Perf tracker</a>
            <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse"
                    data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <span class="w-100"></span>
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
                                <a class="nav-link active" aria-current="page" href="#">
                                    <span data-feather="home"></span>
                                    Summary
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/new">
                                    <span data-feather="file"></span>
                                    New performance
                                </a>
                            </li>
                            <#--          <li class="nav-item">-->
                            <#--            <a class="nav-link" href="#">-->
                            <#--              <span data-feather="shopping-cart"></span>-->
                            <#--              Products-->
                            <#--            </a>-->
                            <#--          </li>-->
                            <#--          <li class="nav-item">-->
                            <#--            <a class="nav-link" href="#">-->
                            <#--              <span data-feather="users"></span>-->
                            <#--              Customers-->
                            <#--            </a>-->
                            <#--          </li>-->
                            <#--          <li class="nav-item">-->
                            <#--            <a class="nav-link" href="#">-->
                            <#--              <span data-feather="bar-chart-2"></span>-->
                            <#--              Reports-->
                            <#--            </a>-->
                            <#--          </li>-->
                            <#--          <li class="nav-item">-->
                            <#--            <a class="nav-link" href="#">-->
                            <#--              <span data-feather="layers"></span>-->
                            <#--              Integrations-->
                            <#--            </a>-->
                            <#--          </li>-->
                        </ul>

                        <#--        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">-->
                        <#--          <span>Saved reports</span>-->
                        <#--          <a class="link-secondary" href="#" aria-label="Add a new report">-->
                        <#--            <span data-feather="plus-circle"></span>-->
                        <#--          </a>-->
                        <#--        </h6>-->
                        <#--        <ul class="nav flex-column mb-2">-->
                        <#--          <li class="nav-item">-->
                        <#--            <a class="nav-link" href="#">-->
                        <#--              <span data-feather="file-text"></span>-->
                        <#--              Current month-->
                        <#--            </a>-->
                        <#--          </li>-->
                        <#--          <li class="nav-item">-->
                        <#--            <a class="nav-link" href="#">-->
                        <#--              <span data-feather="file-text"></span>-->
                        <#--              Last quarter-->
                        <#--            </a>-->
                        <#--          </li>-->
                        <#--          <li class="nav-item">-->
                        <#--            <a class="nav-link" href="#">-->
                        <#--              <span data-feather="file-text"></span>-->
                        <#--              Social engagement-->
                        <#--            </a>-->
                        <#--          </li>-->
                        <#--          <li class="nav-item">-->
                        <#--            <a class="nav-link" href="#">-->
                        <#--              <span data-feather="file-text"></span>-->
                        <#--              Year-end sale-->
                        <#--            </a>-->
                        <#--          </li>-->
                        <#--        </ul>-->
                    </div>
                </nav>

                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Summary</h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <div class="btn-group me-2" role="group" aria-label="Displayed data">
                                <input type="radio" class="btn-check" name="displayed-data" id="distance-radio" autocomplete="off" checked v-model="displayedData" value="Distance" v-on:change="displayDistance">
                                <label class="btn btn-outline-primary" for="distance-radio">Distance</label>

                                <input type="radio" class="btn-check" name="displayed-data" id="time-radio" autocomplete="off" v-model="displayedData" value="Duration" v-on:change="displayDuration">
                                <label class="btn btn-outline-primary" for="time-radio">Time</label>

                                <input type="radio" class="btn-check" name="displayed-data" id="speed-radio" autocomplete="off" v-model="displayedData" value="Speed" v-on:change="displaySpeed">
                                <label class="btn btn-outline-primary" for="speed-radio">Speed</label>
                            </div>
                            <div class="dropdown">
                                <button type="button" class="btn btn-outline-primary dropdown-toggle" id="period-dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span data-feather="calendar"></span>
                                    {{ period }}
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="period-dropdown">
                                    <li><a class="dropdown-item" href="#" v-on:click="displayWeek">This week</a></li>
                                    <li><a class="dropdown-item" href="#" v-on:click="displayMonth">This month</a></li>
                                    <li><a class="dropdown-item" href="#" v-on:click="displayYear">This year</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <#--https://vuejsexamples.net/vue-line-chart/-->
                    <chartjs-line :labels="labels" :data="dataset" :datalabel="displayedData" :bind="true"></chartjs-line>

                    <h2>Performances</h2>
                    <div class="table-responsive">
                        <table class="table table-striped table-sm">
                            <thead>
                            <tr>
                                <th scope="col">Date</th>
                                <th scope="col">Path</th>
                                <th scope="col">Distance (m)</th>
                                <th scope="col">Duration</th>
                                <th scope="col">Average speed (km/h)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list performances as performance>
                                <tr>
                                    <td>${performance.formattedDate}</td>
                                    <td>${performance.path}</td>
                                    <td>${performance.distance}</td>
                                    <td>${performance.formattedDuration}</td>
                                    <td>${performance.speedKmPerHour}</td>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
        </div>
    </div>
    <!-- <script src="../assets/dist/js/bootstrap.bundle.min.js"></script> -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/feather-icons@4.28.0/dist/feather.min.js"
            integrity="sha384-uO3SXW5IuS1ZpFPKugNNWqTZRRglnUJK6UAZ/gxOX80nxEkN9NcGZTftn6RzhGWE"
            crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"
            integrity="sha384-zNy6FEbO50N+Cg5wap8IKA4M/ZnLJgzc6w2NqACZaK0u0FXfOWRRJOnQtpZun8ha"
            crossorigin="anonymous"></script>

    <script src='//unpkg.com/vue-chartjs@2.6.0/dist/vue-chartjs.full.min.js'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.js'></script>
    <script src='//unpkg.com/hchs-vue-charts@1.2.8'></script>

    <script>
        'use strict'
        Vue.use(VueCharts);
        const weekPerformances = [
            <#list weekPerformances as perf>
            {
                date: '${perf.formattedDate}',
                distance: ${perf.distance?long?c},
                duration: ${perf.durationSeconds?long?c},
                speed: ${perf.speedKmPerHour?long?c}
            },
            </#list>
        ]
        const monthPerformances = [
            <#list monthPerformances as perf>
            {
                date: '${perf.formattedDate}',
                distance: ${perf.distance?long?c},
                duration: ${perf.durationSeconds?long?c},
                speed: ${perf.speedKmPerHour?long?c}
            },
            </#list>
        ]
        const yearPerformances = [
            <#list yearPerformances as perf>
            {
                date: '${perf.formattedDate}',
                distance: ${perf.distance?long?c},
                duration: ${perf.durationSeconds?long?c},
                speed: ${perf.speedKmPerHour?long?c}
            },
            </#list>
        ]
        const app = new Vue({
            el: '#app',
            data: {
                period: 'This week',
                dataentry: null,
                displayedData: 'Speed',
                labels: weekPerformances.map(it => it.date),
                dataset: weekPerformances.map(it => it.distance)
            },
            methods: {
                displayWeek: function () {
                    this.period = 'This week'
                    this.labels = weekPerformances.map(it => it.date)
                    this.dataset = weekPerformances.map(it => it.distance)
                    switch (this.displayedData) {
                        case 'Distance':
                            this.dataset = weekPerformances.map(it => it.distance)
                            break;
                        case 'Duration':
                            this.dataset = weekPerformances.map(it => it.duration)
                            break;
                        case 'Speed':
                            this.dataset = weekPerformances.map(it => it.speed)
                            break;
                    }
                },
                displayMonth: function() {
                    this.period = 'This month'
                    this.labels = monthPerformances.map(it => it.date)
                    switch (this.displayedData) {
                        case 'Distance':
                            this.dataset = monthPerformances.map(it => it.distance)
                            break;
                        case 'Duration':
                            this.dataset = monthPerformances.map(it => it.duration)
                            break;
                        case 'Speed':
                            this.dataset = monthPerformances.map(it => it.speed)
                            break;
                    }
                },
                displayYear: function () {
                    this.period = 'This year'
                    this.labels = yearPerformances.map(it => it.date)
                    switch (this.displayedData) {
                        case 'Distance':
                            this.dataset = yearPerformances.map(it => it.distance)
                            break;
                        case 'Duration':
                            this.dataset = yearPerformances.map(it => it.duration)
                            break;
                        case 'Speed':
                            this.dataset = yearPerformances.map(it => it.speed)
                            break;
                    }
                },
                displayDistance: function () {
                    this.displayedData = 'Distance'
                    switch (this.period) {
                        case 'This week':
                            this.dataset = weekPerformances.map(it => it.distance)
                            break;
                        case 'This month':
                            this.dataset = monthPerformances.map(it => it.distance)
                            break;
                        case 'This year':
                            this.dataset = yearPerformances.map(it => it.distance)
                            break;
                    }
                },
                displayDuration: function () {
                    this.displayedData = 'Duration'
                    switch (this.period) {
                        case 'This week':
                            this.dataset = weekPerformances.map(it => it.duration)
                            break;
                        case 'This month':
                            this.dataset = monthPerformances.map(it => it.distance)
                            break;
                        case 'This year':
                            this.dataset = yearPerformances.map(it => it.distance)
                            break;
                    }
                },
                displaySpeed: function () {
                    this.displayedData = 'Speed'
                    switch (this.period) {
                        case 'This week':
                            this.dataset = weekPerformances.map(it => it.speed)
                            break;
                        case 'This month':
                            this.dataset = monthPerformances.map(it => it.speed)
                            break;
                        case 'This year':
                            this.dataset = yearPerformances.map(it => it.speed)
                            break;
                    }
                },
            }
        })
    </script>
</body>
</html>
