# ================================
# GWAP GANG AUTO FIX — v1
# Fixes: folders, CSS, template, CSVs, generator, regeneration
# ================================

Write-Host "▶ GWAP AUTO-FIX STARTING..."

# --- Ensure folders ---
mkdir assets\css, templates, seo, pages\credit -Force | Out-Null

# --- CSS ---
@'
body {
  background:#0b0d10;
  color:#e6e8eb;
  font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Arial,sans-serif;
  line-height:1.6;
  margin:0;
}
h1,h2,h3 { color:#ffffff; }
a { color:#34ff88; text-decoration:none; }
a:hover { color:#7dffb2; }
section { margin-top:3rem; padding-top:2rem; border-top:1px solid rgba(255,255,255,.08); }
.cta { display:inline-block; margin-top:1rem; padding:.7rem 1.4rem; border:1px solid #34ff88; border-radius:6px; }
'@ | Set-Content assets\css\gwap-minimal.css -Encoding UTF8

# --- Template ---
@'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>{{PAGE_TITLE}}</title>
<meta name="description" content="{{META_DESCRIPTION}}">
<link rel="canonical" href="{{BASE_URL}}/{{SLUG}}.html">
<link rel="stylesheet" href="../../assets/css/gwap-minimal.css">
</head>
<body>

<h1>{{PAGE_TITLE}}</h1>

<p>
Fixing your credit doesn’t have to be confusing. This guide explains
<strong>{{PRIMARY_KEYWORD}}</strong> clearly so you know exactly what to do.
</p>

<section>
<h2>What This Page Covers</h2>
<ul>
<li>How {{PRIMARY_KEYWORD}} actually works</li>
<li>Common mistakes to avoid</li>
<li>A simple system you can follow</li>
</ul>
</section>

<section>
<h2>The Strategy</h2>
<p>Accuracy, timing, and consistency — no gimmicks.</p>
</section>

<section>
<h2>Next Step</h2>
<a class="cta" href="#">Get the Credit Checklist</a>
</section>

</body>
</html>
'@ | Set-Content templates\credit-template.html -Encoding UTF8

# --- CSV ---
@'
slug,primary_keyword,title
fix-credit-fast,fix credit fast,Fix Your Credit Fast (What Actually Works)
credit-roadmap,credit roadmap,The Credit Roadmap (Simple & Proven)
'@ | Set-Content seo\credit-money-pages.csv -Encoding UTF8

# --- Generator ---
@'
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
'@ | Set-Content generate-pages.ps1 -Encoding UTF8

# --- Run generator ---
.\generate-pages.ps1

Write-Host "✅ GWAP AUTO-FIX COMPLETE"
