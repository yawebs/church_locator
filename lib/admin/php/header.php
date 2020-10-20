<?php

// $cURLConnection = curl_init();

// curl_setopt($cURLConnection, CURLOPT_URL, 'https://abitaccountservice.info/transactions/balance?currency=NGN');
// curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, true);

// curl_setopt($cURLConnection, CURLOPT_HEADEROPT, ('Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNWVjOThhZmI0ZjIzMTM1ZjczZTI3ZWFlIiwiYXBwbGljYXRpb24iOiI1ZWM5N2U5MTM1NzU5YTQ2MTQ5NTljOGUiLCJyb2xlIjoidXNlciIsImxvZ2luIjoiNWVmNzBiMTZmMzkxNTg1NWM5OTUxOTU4IiwiaWF0IjoxNTkzMjQ4NTM0fQ.DkGH0XHmO41sYW0Y-ELpEHjy8NWfOlY7QakmXMrFyfE'));



// $phoneList = curl_exec($cURLConnection);
// curl_close($cURLConnection);

// $jsonArrayResponse - json_decode($phoneList);

// echo $phoneList;

$crl = curl_init();
$accesstoken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNWVjOThhZmI0ZjIzMTM1ZjczZTI3ZWFlIiwiYXBwbGljYXRpb24iOiI1ZWM5N2U5MTM1NzU5YTQ2MTQ5NTljOGUiLCJyb2xlIjoidXNlciIsImxvZ2luIjoiNWVmNzBiMTZmMzkxNTg1NWM5OTUxOTU4IiwiaWF0IjoxNTkzMjQ4NTM0fQ.DkGH0XHmO41sYW0Y-ELpEHjy8NWfOlY7QakmXMrFyfE';
$headr = array();
$headr[] = 'Content-length: 0';
$headr[] = 'Content-type: application/json';
$headr[] = 'Authorization: Bearer ' . $accesstoken;
curl_setopt($crl, CURLOPT_URL, 'https://abitaccountservice.info/transactions/balance?currency=NGN');
curl_setopt($crl, CURLOPT_HTTPHEADER, $headr);
curl_setopt($crl, CURLOPT_POST, true);
$rest = curl_exec($crl);

curl_close($crl);

print_r($rest);
