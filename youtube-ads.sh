#!/usr/bin/env bash
# Cleanup previous list of domains files
rm /var/log/sublist-youtube-result.txt
# Retrieve all .googlevideo.com subdomains
python sublist/Sublist3r-master/sublist3r.py -d googlevideo.com -n -o /var/log/sublist-youtube-result.txt
# Any .googlevideo.com subdomains starting with 'r' would be filtered in a file
grep ^r /var/log/sublist-youtube-result.txt >> /var/log/sublist-youtube-filtered.txt
# Any .googlevideo.com subdomains containing 's' from the previous filtered list will be filtered in a file
sed 's/\s.*$//' /var/log/sublist-youtube-filtered.txt >> /var/log/sublist-youtube-ads.txt
# Place findings in Pihole blacklist text file
cat /var/log/sublist-youtube-ads.txt > blacklist.txt
# Get unique values
perl -i -ne 'print if ! $x{$_}++' blacklist.txt
# Get unique values
# chown -R pihole. /etc/pihole
# Pipe findings into pihole db
cat blacklist.txt
