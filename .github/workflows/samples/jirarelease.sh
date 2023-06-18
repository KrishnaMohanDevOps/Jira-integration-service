#!/bin/sh

content=$(curl --location  $RESTAPI \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $TOKEN"| jq -r '.values[].id')

echo $content

report="meda-verification-service-trivyreport"
testing="verification-service"

curl --location 'https://devopsprodemo.atlassian.net/gateway/api/graphql' \
--header 'X-ExperimentalApi:  AddRelatedWorkToVersion' \
--header 'Content-Type: application/json' \
--header "Authorization: Basic  $TOKEN" \
--data '{"query":"mutation useAddGenericLinkRelatedWork_addRelatedWorkMutation($versionId: ID!, $relatedWorkId: ID!, $url: URL, $title: String, $category: String!) {\n  jira {\n    addRelatedWorkToVersion(input: {versionId: $versionId, relatedWorkId: $relatedWorkId, url: $url, title: $title, category: $category} ) {\n      success\n      errors {\n        message\n      }\n    }\n  }\n}",
 "variables":{"versionId":"'"$versionid/$content"'","relatedWorkId":"'"$buildnumber"'","url":"'"$url/dashboard?id=meda-customer-service"'","title":"'"$report"'","category":"'"$testing"'"}}'
