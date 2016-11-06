context("runtest")

test_that("canRunTestDryRun1", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   connectivity = "Cable", runs = 2L, 
                   firstViewOnly = TRUE, video = TRUE)
  # webpagetest -d test -k akey -l aLocation -y Cable -r 2 -fv myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation.Cable&connectivity=Cable", 
                     "&runs=2&fvonly=1&video=1&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun2", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   private = TRUE, label = "myLabel", 
                   stopAtDocumentComplete = TRUE, 
                   disableJavaScript = TRUE, 
                   clearCerts = TRUE, ignoreSSL = TRUE)
  # webpagetest -d test -k akey -l aLocation -L myLabel -pisCR myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation&private=1&label=myLabel", 
                     "&web10=1&noscript=1&clearcerts=1&ignoreSSL=1&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun3", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   disableCompatibilityView = TRUE, tcpDump = TRUE, 
                   saveResponseBodies = TRUE, 
                   keepOriginalUserAgent = TRUE, domElement = "someEl", 
                   minimumDuration = 30L)
  # webpagetest -d test -k akey -l aLocation -TuOK -m someEL -N 30 myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL",
                     "&k=akey&location=aLocation&standards=1&tcpdump=1",
                     "&bodies=1&keepua=1&domelement=someEl&time=30&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun4", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   tester = "aPC", emulateMobile = TRUE, timeline = TRUE,
                   timelineCallStack = 2L, chromeTrace = TRUE, 
                   netLog =  TRUE)
  # webpagetest -d test -k akey -l aLocation -E aPC -WM -J -qG myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation&tester=aPC&mobile=1", 
                     "&timeline=1&timelineStack=2&trace=1&netlog=1&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun5", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   dataReduction = TRUE, userAgent = "myUA", 
                   commandLine = "coms", login = "user", 
                   password = "pass", sensitive = TRUE)
  # webpagetest -d test -k akey -l aLocation -E aPC -WM -J -qG myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL",
                     "&k=akey&location=aLocation&dataReduction=1",
                     "&uastring=myUA&cmdline=coms&login=user",
                     "&password=pass&sensitive=1&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun6", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   disableHTTPHeaders = TRUE, block = c("url1", "url2"), 
                   spof = c("domain1", "domain2"), 
                   customMetrics = "customMetric", 
                   authenticationType = 1L, 
                   notifyEmail = "me@xyz.com")
  # webpagetest -d test -k akey -H -b "url1 url2" -Z "domain1 domain2" 
  #    -c customMetric -a 1 -n me@xyz.com myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation&noheaders=1", 
                     "&block=url1%20url2&spof=domain1%20domain2", 
                     "&custom=customMetric&authType=1", 
                     "&notify=me%40xyz.com&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun7", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   pingback = "xyz.com", bandwidthDown = 50L, 
                   bandwidthUp = 50L, latency = 4000L, 
                   packetLossRate = 30L, disableOptimization = TRUE)
  # webpagetest -d test -k akey -B xyz.com -D 50 -U 50 -Y 4000 
  #     -P 30 -z myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation&pingback=xyz.com", 
                     "&bwDown=50&bwUp=50&latency=4000&plr=30", 
                     "&noopt=1&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun8", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   disableScreenshot = TRUE, 
                   fullResolutionScreenshot = TRUE, jpegQuality = 60L, 
                   medianVideo = TRUE, htmlBody = TRUE, 
                   tsView = "someId")
  # webpagetest -d test -k akey -IF -j 60 -A --htmlbody 
  #     --tsview someId myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation&noimages=1&pngss=1", 
                     "&iq=60&mv=1&htmlbody=1&tsview_id=someId&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun9", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   tsViewConfigs = "tsConfig", affinity = "hash", 
                   priority = 2L, 
                   blockAds = TRUE, continuousVideoCapture = TRUE, 
                   forceSpdy3 = TRUE)
  # webpagetest -d test -k akey --tsviewconfigs tsConfig --affinity hash 
  #     --priority 2 --noads --continuous --spdy3 myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation&tsview_configs=tsConfig", 
                     "&affinity=hash&priority=2&blockads=1", 
                     "&continuousVideo=1&spdy3=1&f=json")
  expect_identical(rtest, drExpect)
})

test_that("canRunTestDryRun10", {
  WPT <- server()
  rtest <- runTest(WPT, "myURL", key = "akey", location = "aLocation", 
                   forceSoftwareRendering = TRUE,  requestId = "someId", 
                   breakDown = TRUE, domains = TRUE, pageSpeed = TRUE, 
                   requests = TRUE, medianMetric = "loadTime", 
                   medianRun = "median")
  # webpagetest -d test -k akey --swrender -e someId --breakdown --domains
  #     --pagespeed --requests --median loadTime --medianrun median myURL
  drExpect <- paste0("http://www.webpagetest.org/runtest.php?url=myURL", 
                     "&k=akey&location=aLocation&swrender=1&r=someId", 
                     "&breakdown=1&domains=1&pagespeed=1&requests=1", 
                     "&medianMetric=loadTime&medianRun=median&f=json")
  expect_identical(rtest, drExpect)
})

