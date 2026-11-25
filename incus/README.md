# Open links in Dolly’s browser

The Arch daily and Antithesis Incus images include the browser helper. For existing containers, attach the matching Incus profiles on Dolly as described in the [Dolly setup instructions](https://github.com/SeanTAllen/nix-configurations#open-container-links-in-brave-on-dolly). Then run this once in Bash on Dolly, from the root of this repository with both containers running. The files are installed directly into each container.

```bash
(
  set -e
  for guest in pony-dolly antithesis-dolly; do
    incus exec "$guest" -- sh -ec '
      if [ ! -x /usr/bin/python3 ]; then
        pacman -S --needed python
      fi'
    incus file push --create-dirs --uid 0 --gid 0 --mode 0755 \
      incus/open-host-browser "$guest/usr/local/bin/open-host-browser"
    incus file push --create-dirs --uid 0 --gid 0 --mode 0644 \
      incus/host-browser.fish "$guest/etc/fish/conf.d/host-browser.fish"
  done
)
```

Open a new fish shell as `sean` in each container to pick up `BROWSER`.
