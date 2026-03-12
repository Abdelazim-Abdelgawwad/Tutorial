[![Citations](https://api.juleskreuer.eu/citation-badge.php?doi=10.1021/acs.jctc.4c01272)](https://scholar.google.com/scholar?q=10.1021/acs.jctc.4c01272)

name: Update GA Stats

on:
  schedule:
    - cron: '0 6 * * *'  # runs daily at 6am UTC
  workflow_dispatch:

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Fetch GA4 Event Count
        id: ga
        env:
          GA_PROPERTY_ID: ${{ secrets.GA_PROPERTY_ID }}
          GA_CREDENTIALS: ${{ secrets.GA_CREDENTIALS }}
        run: |
          pip install google-analytics-data --break-system-packages
          python3 .github/scripts/fetch_ga.py

      - name: Update README
        run: |
          COUNT=$(cat /tmp/event_count.txt)
          sed -i "s/event-count-[0-9.]*K/event-count-${COUNT}/" README.md

      - name: Commit changes
        run: |
          git config user.name "github-actions"
          git config user.email "actions@github.com"
          git add README.md
          git commit -m "Update GA event count" || echo "No changes"
          git push
