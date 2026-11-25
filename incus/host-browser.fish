if test -S /run/host-browser.sock; and test (id -u) -eq 1000
    set -gx BROWSER /usr/local/bin/open-host-browser
end
