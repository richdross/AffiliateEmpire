$template = Get-Content templates\credit-template.html -Raw
$pages = Import-Csv seo\credit-money-pages.csv

foreach ($p in $pages) {
  $meta = "Learn how to $($p.primary_keyword) using a proven step-by-step system."
  $html = $template `
    -replace "{{PAGE_TITLE}}", $p.title `
    -replace "{{PRIMARY_KEYWORD}}", $p.primary_keyword `
    -replace "{{META_DESCRIPTION}}", $meta `
    -replace "{{SLUG}}", $p.slug `
    -replace "{{BASE_URL}}", "https://gwapgang.com"

  Set-Content "pages\credit\$($p.slug).html" $html -Encoding UTF8
  Write-Host "✔ Generated $($p.slug).html"
}
