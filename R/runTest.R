#' Run test
#'
#' Run test
#'
#' @template server 
#' @param urlOrScript URL or script string
#' @template key 
#' @template location 
#' @template connectivity 
#' @template runs 
#' @template firstViewOnly 
#' @template video 
#' @template private 
#' @template label 
#' @template stopAtDocumentComplete 
#' @template disableJavaScript 
#' @template clearCerts 
#' @template ignoreSSL 
#' @template disableCompatibilityView 
#' @template tcpDump 
#' @template saveResponseBodies 
#' @template keepOriginalUserAgent 
#' @template domElement 
#' @template minimumDuration 
#' @template tester 
#' @template emulateMobile 
#' @template timeline 
#' @template timelineCallStack 
#' @template chromeTrace 
#' @template netLog 
#' @template dataReduction 
#' @template userAgent 
#' @template commandLine 
#' @template login 
#' @template password 
#' @template sensitive 
#' @template disableHTTPHeaders 
#' @template block 
#' @template spof 
#' @template customMetrics 
#' @template authenticationType 
#' @template notifyEmail 
#' @template pingback 
#' @template bandwidthDown 
#' @template bandwidthUp 
#' @template latency 
#' @template packetLossRate 
#' @template disableOptimization 
#' @template disableScreenshot 
#' @template fullResolutionScreenshot 
#' @template jpegQuality 
#' @template medianVideo 
#' @template htmlBody 
#' @template tsView 
#' @template tsViewConfigs 
#' @template affinity 
#' @template priority 
#' @template blockAds 
#' @template continuousVideoCapture 
#' @template forceSpdy3 
#' @template forceSoftwareRendering 
#' @template  requestId 
#' @template breakDown 
#' @template domains 
#' @template pageSpeed 
#' @template requests 
#' @template medianMetric 
#' @template medianRun 
#' @template dryRun 
#' @template ellipsis 
#'
#' @return a list of results
#' @export
#'
#' @example /inst/examples/docs/runTest.R

runTest <- function(server, urlOrScript, key = NULL, location, 
                    connectivity = NULL, runs = NULL, 
                    firstViewOnly = FALSE, video = FALSE, 
                    private = FALSE, label = NULL, 
                    stopAtDocumentComplete = FALSE, 
                    disableJavaScript = FALSE, 
                    clearCerts = FALSE, ignoreSSL = FALSE, 
                    disableCompatibilityView = FALSE, tcpDump = FALSE, 
                    saveResponseBodies = FALSE, 
                    keepOriginalUserAgent = FALSE, domElement = NULL, 
                    minimumDuration = NULL, 
                    tester = NULL, emulateMobile = FALSE, timeline = FALSE,
                    timelineCallStack = NULL, chromeTrace = FALSE, 
                    netLog =  FALSE,
                    dataReduction = FALSE, userAgent = NULL, 
                    commandLine = NULL, login = NULL, password = NULL, 
                    sensitive = FALSE,
                    disableHTTPHeaders =FALSE, block = NULL, spof = NULL, 
                    customMetrics = NULL, authenticationType = NULL, 
                    notifyEmail = NULL, 
                    pingback = NULL, bandwidthDown = NULL, 
                    bandwidthUp = NULL, latency = NULL, 
                    packetLossRate = NULL, disableOptimization = FALSE, 
                    disableScreenshot = FALSE, 
                    fullResolutionScreenshot = FALSE, jpegQuality = NULL, 
                    medianVideo = FALSE, htmlBody = FALSE, 
                    tsView = NULL, 
                    tsViewConfigs = NULL, affinity = NULL, priority = NULL, 
                    blockAds = FALSE, continuousVideoCapture = FALSE, 
                    forceSpdy3 = FALSE, 
                    # pollResults, waitResults, timeout, # non API ADD?
                    forceSoftwareRendering = FALSE,  requestId = NULL, 
                    breakDown = FALSE, domains = FALSE, pageSpeed = FALSE, 
                    requests = FALSE, medianMetric = NULL, 
                    medianRun = NULL, 
                    # specs, reporter, # non API ADD?
                    dryRun = TRUE, ...){
  checkArgs(server, urlOrScript, key, location, connectivity, runs, 
            firstViewOnly, video, 
            private, label, stopAtDocumentComplete, disableJavaScript, 
            clearCerts, ignoreSSL, disableCompatibilityView, tcpDump, 
            saveResponseBodies, keepOriginalUserAgent, domElement, 
            minimumDuration, tester, emulateMobile, timeline,
            timelineCallStack, chromeTrace, netLog, dataReduction, 
            userAgent, commandLine, login, password, sensitive, 
            disableHTTPHeaders, block, spof, customMetrics, 
            authenticationType, notifyEmail, pingback, bandwidthDown, 
            bandwidthUp, latency, packetLossRate, disableOptimization,
            disableScreenshot, fullResolutionScreenshot, jpegQuality, 
            medianVideo, htmlBody, tsView, tsViewConfigs, affinity, 
            priority, blockAds, continuousVideoCapture, forceSpdy3,
            forceSoftwareRendering,  requestId, 
            breakDown, domains, pageSpeed, 
            requests, medianMetric, medianRun)
  if(!is.null(connectivity)){
    location <- paste(location, connectivity, sep = ".")
  }
  body <- list(
    list(urlOrScript, "url"),
    list(key, WPTOptions[["key"]][["api"]]),
    list(location, WPTOptions[["location"]][["api"]]),
    list(connectivity, WPTOptions[["connectivity"]][["api"]]),
    list(runs, WPTOptions[["runs"]][["api"]]),
    list(false2Null(firstViewOnly), 
         WPTOptions[["firstViewOnly"]][["api"]]),
    list(false2Null(video), WPTOptions[["video"]][["api"]]),
    list(false2Null(private), WPTOptions[["private"]][["api"]]),
    list(label, WPTOptions[["label"]][["api"]]),
    list(false2Null(stopAtDocumentComplete), 
         WPTOptions[["stopAtDocumentComplete"]][["api"]]),
    list(false2Null(disableJavaScript), 
         WPTOptions[["disableJavaScript"]][["api"]]),
    list(false2Null(clearCerts), WPTOptions[["clearCerts"]][["api"]]),
    list(false2Null(ignoreSSL), WPTOptions[["ignoreSSL"]][["api"]]),
    list(false2Null(disableCompatibilityView), 
         WPTOptions[["disableCompatibilityView"]][["api"]]),
    list(false2Null(tcpDump), WPTOptions[["tcpDump"]][["api"]]),
    list(false2Null(saveResponseBodies), 
         WPTOptions[["saveResponseBodies"]][["api"]]),
    list(false2Null(keepOriginalUserAgent), 
         WPTOptions[["keepOriginalUserAgent"]][["api"]]),
    list(domElement, WPTOptions[["domElement"]][["api"]]),
    list(minimumDuration, WPTOptions[["minimumDuration"]][["api"]]),
    list(tester, WPTOptions[["tester"]][["api"]]),
    list(false2Null(emulateMobile), 
         WPTOptions[["emulateMobile"]][["api"]]),
    list(false2Null(timeline), WPTOptions[["timeline"]][["api"]]),
    list(timelineCallStack, WPTOptions[["timelineCallStack"]][["api"]]),
    list(false2Null(chromeTrace), WPTOptions[["chromeTrace"]][["api"]]),
    list(false2Null(netLog), WPTOptions[["netLog"]][["api"]]),
    list(false2Null(dataReduction), 
         WPTOptions[["dataReduction"]][["api"]]),
    list(userAgent, WPTOptions[["userAgent"]][["api"]]),
    list(commandLine, WPTOptions[["commandLine"]][["api"]]),
    list(login, WPTOptions[["login"]][["api"]]),
    list(password, WPTOptions[["password"]][["api"]]),
    list(false2Null(sensitive), WPTOptions[["sensitive"]][["api"]]),
    list(false2Null(disableHTTPHeaders), 
         WPTOptions[["disableHTTPHeaders"]][["api"]]),
    list(pasteOrNULL(block), WPTOptions[["block"]][["api"]]),
    list(pasteOrNULL(spof), WPTOptions[["spof"]][["api"]]),
    list(customMetrics, WPTOptions[["customMetrics"]][["api"]]),
    list(authenticationType, WPTOptions[["authenticationType"]][["api"]]),
    list(notifyEmail, WPTOptions[["notifyEmail"]][["api"]]),
    list(pingback, WPTOptions[["pingback"]][["api"]]),
    list(bandwidthDown, WPTOptions[["bandwidthDown"]][["api"]]),
    list(bandwidthUp, WPTOptions[["bandwidthUp"]][["api"]]),
    list(latency, WPTOptions[["latency"]][["api"]]),
    list(packetLossRate, WPTOptions[["packetLossRate"]][["api"]]),
    list(false2Null(disableOptimization), 
         WPTOptions[["disableOptimization"]][["api"]]),
    list(false2Null(disableScreenshot), 
         WPTOptions[["disableScreenshot"]][["api"]]),
    list(false2Null(fullResolutionScreenshot), 
         WPTOptions[["fullResolutionScreenshot"]][["api"]]),
    list(jpegQuality, WPTOptions[["jpegQuality"]][["api"]]),
    list(false2Null(medianVideo), WPTOptions[["medianVideo"]][["api"]]),
    list(false2Null(htmlBody), WPTOptions[["htmlBody"]][["api"]]),
    list(tsView, WPTOptions[["tsView"]][["api"]]),

    list(tsViewConfigs, WPTOptions[["tsViewConfigs"]][["api"]]),
    list(affinity, WPTOptions[["affinity"]][["api"]]),
    list(priority, WPTOptions[["priority"]][["api"]]),
    list(false2Null(blockAds), WPTOptions[["blockAds"]][["api"]]),
    list(false2Null(continuousVideoCapture), 
         WPTOptions[["continuousVideoCapture"]][["api"]]),
    list(false2Null(forceSoftwareRendering), 
         WPTOptions[["forceSoftwareRendering"]][["api"]]),
    list(false2Null(forceSpdy3), WPTOptions[["forceSpdy3"]][["api"]]),
    list(requestId, WPTOptions[["requestId"]][["api"]]),
    list(false2Null(breakDown), WPTOptions[["breakDown"]][["api"]]),
    list(false2Null(domains), WPTOptions[["domains"]][["api"]]),
    list(false2Null(pageSpeed), WPTOptions[["pageSpeed"]][["api"]]),
    list(false2Null(requests), WPTOptions[["requests"]][["api"]]),
    list(medianMetric, WPTOptions[["medianMetric"]][["api"]]),
    list(medianRun, WPTOptions[["medianRun"]][["api"]]),
    list("json", "f")
  )
  body <- setNames(lapply(body, "[[", 1), 
                   vapply(body, "[[", character(1), 2))   
  res <- sendQuery(url = server[["url"]], path = WPTPaths[["test"]], 
                   body = body, origin = "runTest", dryRun = dryRun,
                   ...)
  if(dryRun){return(res)}
  res
} 

