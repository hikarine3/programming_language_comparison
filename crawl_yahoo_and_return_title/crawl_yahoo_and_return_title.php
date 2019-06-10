<?php
$target_url = "https://www.yahoo.com/";
$context = stream_context_create(array('http' => array(
    'method' => "GET",
    'header' => implode("\r\n", array('Accept-Encoding: gzip,deflate'))
)));
$content = file_get_contents($target_url, false, $context);
if (isGzipResponse($http_response_header)) {
    $content = gzdecode($content);
}
$matches = [];
if( preg_match('!<title>(.*)</title>!is', $content, $matches) ) {
    print $matches[1]."\n";
}

function isGzipResponse($headers) {
    foreach($headers as $header) {
        if (stristr($header, 'content-encoding') and stristr($header, 'gzip')) {
            return true;
        }
    }
}
