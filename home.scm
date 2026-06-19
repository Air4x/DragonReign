(use-modules (gnu)
	     (gnu home)
             (gnu home services)
             (gnu home services shells)
	     (gnu home services shepherd)
	     (gnu home services sound)
	     (gnu home services desktop)
             (gnu services)
	     (gnu packages)
             (gnu packages admin)
             (gnu packages base)	     
             (gnu packages perl)
             (gnu packages perl6)	     
             (gnu packages lisp)
	     (gnu packages mpd)
	     (gnu packages emacs)
	     (gnu packages emacs-xyz)
	     (gnu packages fonts)
	     (gnu packages wm)
	     (gnu packages syncthing)
	     (gnu packages gnuzilla)
	     (gnu packages telegram)
	     (gnu packages package-management)
	     (gnu packages freedesktop)
	     (gnu packages terminals)
	     (gnu packages shellutils)
	     (gnu packages rust-apps)
	     (gnu packages aspell)
	     (gnu packages emulators)
	     (gnu packages tex)
	     (gnu packages qt)
	     (gnu packages version-control)
	     (gnu packages xorg)
	     (gnu packages xdisorg)
	     (gnu home services syncthing)
	     (gnu home services guix)
	     (air4x packages zen)
	     (nongnu packages messaging)
	     (nongnu packages emacs)
	     (guix channels)
             (guix gexp)
	     (guix packages)
	     (guix utils))


(define pkgs
  (map specification->package '("font-fira-code"
				"font-nerd-fira-code"
				"font-et-book"
				"font-google-noto-emoji"
				"htop"
				"acpi"
				"sbcl"
				"guile"
				"rofi"
				"cliphist"
				"wl-clipboard"
				"grim"
				"slurp"
				"eza"
				"libadwaita"
				"hicolor-icon-theme"
				"dunst"
				"syncthing"
				"xkeyboard-config"
				"sway"
				"swayidle"
				"xdg-desktop-portal"
				"xdg-desktop-portal-wlr"
				"swaybg"
				"waybar"
				"alacritty"
				"starship"
				"ripgrep"
				"mpd"
				"mpd-mpc"
				"ncmpcpp"
				"zen-browser-bin"
				"rakudo"
				"perl"
				"perl6-zef"
				"emacs-pgtk"
				"emacs-telega"
				"emacs-raku-mode"
				"emacs-slime"
				"emacs-all-the-icons"
				"emacs-ligature"
				"emacs-mixed-pitch"
				"emacs-consult"
				"emacs-vertico"
				"emacs-marginalia"
				"emacs-orderless"
				"emacs-embark"
				"emacs-org"
				"emacs-jinx"
				"emacs-olivetti"
				"emacs-org-roam"
				"emacs-org-roam-ui"
				"emacs-org-contacts"
				"emacs-gnuplot"
				"emacs-org-bullets"
				"emacs-org-appear"
				"emacs-htmlize"
				"emacs-pdf-tools"
				"emacs-org-tree-slide"
				"emacs-eat"
				"emacs-yasnippet"
				"emacs-yasnippet-snippets"
				"emacs-paredit"
				"emacs-rainbow-delimiters"
				"emacs-geiser"
				"emacs-geiser-guile"
				"emacs-corfu"
				"emacs-cape"
				"emacs-magit"
				"emacs-auctex"
				"emacs-elpher"
				"emacs-zig-mode"
				"emacs-gruvbox-theme"
				"aspell-dict-en"
				"aspell-dict-it"
				"icedove-wayland"
				"telegram-desktop"
				"signal-desktop"
				"flatpak"
				"flatpak-xdg-utils"
				"texlive-scheme-basic"
				"texlive-collection-latexrecommended"
				"texlive-collection-fontsrecommended"
				"texlive-collection-latexextra"
				"texlive-dvipng"
				"texlive-xetex"
				"texlive-hyperref"
				"texlive-fmtcount"
				"emacs-org-texlive-collection"
				"retroarch"
				"retroarch-assets"
				"libretro-slang-shaders"
				"libretro-beetle-gba"
				"libretro-bsnes-jg"
				"libretro-bsnes-hd"
				"qtwayland"
				"egl-wayland"
				"pipemixer"
				"github-cli")))

;; MPD
(define (home-mpd-service config)
  (list (shepherd-service
	  (provision '(mpd))
	  (documentation "Run mpd the music player deamon")
	  (start #~(make-system-constructor "mpd"))
	  (stop #~(make-system-destructor "mpd" "--kill")))))

(define home-mpd-service-type
  (service-type
   (name 'mpd)
   (default-value '())
   (extensions (list (service-extension
		      home-shepherd-service-type
		      home-mpd-service)))
   (description "Mpd deamon")))



;; emacs server
(define (home-emacs-service config)
  (list (shepherd-service
	 (provision '(emacs))
	 (documentation "Start emacs as a daemon")
	 (start #~(make-forkexec-constructor (list (string-append #$emacs-pgtk "/bin/emacs")
						   "--fg-daemon"
						   "--chdir" (getenv "HOME"))))
	 (stop #~(make-kill-destructor)))))

(define home-emacs-service-type
  (service-type
   (name 'emacs)
   (default-value #f)
   (extensions (list (service-extension
		      home-shepherd-service-type
		      home-emacs-service)))
   (description "Emacs as a daemon to use with emacsclient")))

(home-environment
  (packages pkgs)
  (services
  (list
   (service home-bash-service-type
	    (home-bash-configuration
	     (guix-defaults? #t)
	     (environment-variables '(("QT_QPA_PLATFORM" . "wayland")
				      ("PATH" . "$PATH:/home/mario/.local/bin/")
				      ("XDG_CURRENT_DESKTOP" . "sway")))
	     (bashrc (list (local-file "bash/conf")))
	     (aliases '(("ls" . "eza")
			("la" . "eza -a")
			("ll" . "eza -al")
			("emc" . "emacsclient -nw")
			("wifi" . "nmcli d w")
			("connect" . "nmcli d w c")))
	     (bash-profile (list (local-file "bash/profile.conf")))))
   (service home-files-service-type
	    `((".config/sway/config" ,(local-file "sway/config"))
	      (".config/emacs/Air4x.org" ,(local-file "emacs/Air4x.org"))
	      (".config/mpd/mpd.conf" ,(local-file "mpd/mpd.conf"))
	      (".config/dunst/dunstrc" ,(local-file "dunst/dunstrc"))
	      (".config/waybar/config.jsonc" ,(local-file "waybar/config.jsonc"))
	      (".config/waybar/style.css" ,(local-file "waybar/style.css"))
	      (".config/alacritty/alacritty.toml" ,(local-file "alacritty/alacritty.toml"))
	      ("Immagini/wallpaper.jpg" ,(local-file "ultimate-blue-eyes.jpg"))
	      ("Modelli/neocities.org" ,(local-file "templates/neocities.org"))
	      (".local/bin/orgzly-ignore" ,(local-file "scripts/orgzly-ignore" #:recursive? #t))
	      (".local/bin/note-capture-image" ,(local-file "scripts/note-capture-image" #:recursive? #t))
	      (".local/bin/wifi_menu" ,(local-file "scripts/wifi_menu" #:recursive? #t))
	      (".local/bin/yt-url" ,(local-file "scripts/yt-url" #:recursive? #t))))
   (simple-service 'variant-packages-service
                   home-channels-service-type
                   (list
                    (channel
		     (name 'nonguix)
		     (url "https://gitlab.com/nonguix/nonguix")
		     ;; Enable signature verification:
		     (introduction
		      (make-channel-introduction
		       "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
		       (openpgp-fingerprint
			"2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
		    (channel
		     (name 'clocktower)
		     (url "https://codeberg.org/TohsakaTypeclass/clocktower")
		     (branch "master")
		     (introduction
		      (make-channel-introduction
		       "9fb086fa9ee955c7daf755a5b114eedc030de99d"
		       (openpgp-fingerprint
			"4B1E F810 76ED 1A25 D15C CB18 4572 A777 FF18 DBCC"))))  
		    (channel
		     (name 'boot-sector-launch)
		     (url "https://github.com/Air4x/boot-sector-launch.git")
		     (branch "master")
		     (introduction
		      (make-channel-introduction
  		       "fb5c7f05324ec8228ea4e3ed3f0af7eda38a535d"
		       (openpgp-fingerprint
			"F2FEFE669117674C003D55609BDFFC914D670025"))))))
   (service home-dbus-service-type)
   (service home-syncthing-service-type)
   (service home-mpd-service-type)
   (service home-emacs-service-type)
   (service home-pipewire-service-type))))
