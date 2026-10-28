(use-modules
 (gnu)
 (gnu home)
 (gnu home services)
 (gnu home services desktop)
 (gnu home services shepherd)
 (gnu home services sound)
 (gnu home services shells)
 (gnu services)
 (gnu packages)
 (gnu packages aspell)
 (gnu packages emacs)
 (gnu packages emacs-xyz)
 (gnu packages emulators)
 (gnu packages fonts)
 (gnu packages freedesktop)
 (gnu packages gnuzilla)
 (gnu packages mpd)
 (gnu packages package-management)
 (gnu packages qt)
 (gnu packages rust-apps)
 (gnu packages shellutils)
 (gnu packages syncthing)
 (gnu packages tcl)
 (gnu packages telegram)
 (gnu packages terminals)
 (gnu packages tex)
 (gnu packages version-control)
 (gnu packages wm)
 (gnu packages window-management)
 (gnu packages xdisorg)
 (gnu packages xorg)
 (gnu packages base)	     
 (gnu packages lisp)
 (gnu packages perl)
 (gnu packages perl6)
 (gnu packages admin)
 (gnu packages kde-internet)
 (games packages minecraft)
 (gnu home services guix)
 (gnu home services syncthing)
 (air4x packages zen)
 (nongnu packages emacs)
 (nongnu packages messaging)
 (guix channels)
 (guix packages)
 (guix transformations)
 (guix utils)
 (guix gexp))


(define fonts
  '("font-fira-code"
    "font-nerd-fira-code"
    "font-et-book"
    "font-google-noto-emoji"
    "font-google-noto"
    "font-google-noto-serif-cjk"
    "font-google-noto-sans-cjk"))

(define clis
  '("htop"
    "acpi"
    "eza"
    "ripgrep"
    "pipemixer"
    "ffmpeg"
    "imagemagick"
    "pv"
    "pdftk"
    "parallel"
    "jq"
    "direnv"
    "curl"
    "wget"
    "tldr"
    "git"
    "rlwrap"
    "gnuplot"
    "yt-dlp"
    "zip"
    "unzip"
    "7zip"
    "gzip"
    "recutils"))

(define IM
  '("icedove-wayland"
    "telegram-desktop"
    "jami"
    "mumble"))

(define multimedia-editing
  '("kdenlive"
    ;;    "krita"
    "gimp"))

(define sway-core
  '("sway"
    "swaybg"
    "rofi"
    "xkeyboard-config"
    "alacritty"
    "starship"))

(define desktop-common
  '("cliphist"
    "wl-clipboard"
    "grim"
    "slurp"
    "libadwaita"
    "hicolor-icon-theme"
    "dunst"
    "syncthing"
    "kdeconnect"
    "xdg-utils"
    "xdg-user-dirs"))

(define desktop-extra
  '("xdg-desktop-portal"
    "xdg-desktop-portal-wlr"
    "zen-browser-bin"
    "qbittorrent"))


(define desktop-tower
  '("eww"))

(define desktop-portable
  '("swayidle"
    "waybar"
    "swaylock"))

(define music
  '("mpd"
    "mpd-mpc"
    "ncmpcpp"))

(define emacs-core
  '("emacs-pgtk"
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
    "emacs-gruvbox-theme"
    "emacs-corfu"
    "emacs-cape"
    "emacs-magit"
    "emacs-agitjo"
    "emacs-org-texlive-collection"
    "emacs-guix"
    "emacs-envrc"))


(define emacs-extra
  '("emacs-elpher"
    "emacs-gptel"))

(define dictionaries
  '("aspell-dict-en"
    "aspell-dict-it"))

(define zig
  '("zig"
    "zig-zls"
    "emacs-zig-mode"))

(define raku
  '("rakudo"
    "perl6-zef"))

(define raku-dev
  '("emacs-raku-mode"))

(define latex-dev
  '("emacs-auctex"))

(define perl
  '("perl"
    "perl-tk"))

(define lisp-dev
  '("emacs-paredit"
    "emacs-rainbow-delimiters"))

(define cl
  '("emacs-sly"
    "emacs-sly-asdf"))

(define guile
  '("guile"
    "emacs-geiser"
    "emacs-geiser-guile"))

(define emulators
  '("retroarch"
    "retroarch-assets"
    "libretro-slang-shaders"
    "libretro-beetle-gba"
    "libretro-bsnes-jg"
    "libretro-bsnes-hd"))

(define development
  '("github-cli"))

(define flatpak-core
  '("flatpak"
    "flatpak-xdg-utils"))

(define misc
  '("qtwayland"
    "egl-wayland"
    "gparted"
    "node"))

(define games
  '("prismlauncher"
    "xonotic"
    "luanti"))

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


;; Kdeconnect service
(define (home-kdeconnect-service config)
  (list (shepherd-service
	  (provision '(kdeconnect))
	  (requirement '(wayland-display))
	  (start #~(lambda args
		     (let* ((runtime-dir (getenv "XDG_RUNTIME_DIR"))
			    (qa-platform "QT_QPA_PLATFORM=wayland")
			    (env (cons (string-append "XDG_RUNTIME_DIR=" runtime-dir) (cons qa-platform (environ)))))
		      (apply
		       (make-forkexec-constructor
			(list (string-append
			       #$kdeconnect
			       "/bin/kdeconnectd"))
			#:environment-variables env)
		       args))))
	  (stop #~(make-kill-destructor)))))

(define home-kdeconnect-service-type
  (service-type
    (name 'kdeconnect)
    (default-value #f)
    (extensions (list (service-extension
		       home-shepherd-service-type
		       home-kdeconnect-service)))
    (description "Manages kdeconnect")))

;; Eww service
(define (home-eww-service config)
  (list (shepherd-service
	  (provision '(eww))
	  (requirement '(wayland-display))
	  (start #~(lambda args
		     (use-modules (ice-9 ftw))
		     (let* ((runtime-dir (getenv "XDG_RUNTIME_DIR"))
			    (swaysock (let ((dir (opendir runtime-dir)))
					(let loop ((entry (readdir dir)))
					  (cond
					   ((eof-object? entry)
					    (closedir dir)
					    #f)
					   ((string-prefix? "sway-ipc." entry)
					    (let ((path (string-append runtime-dir "/" entry)))
					      (closedir dir)
					      path))
					   (else
					    (loop (readdir dir)))))))
			    (env (cons (string-append "SWAYSOCK=" swaysock) (environ))))
		       (apply
			(make-forkexec-constructor
			 (list (string-append
				#$eww
				"/bin/eww")
			       "daemon"
			       "--no-daemonize"
			       "--config"
			       (string-append
				(getenv "HOME")
				"/.config/eww/"))
			 #:environment-variables env)
			args))))
	  (stop #~(make-kill-destructor)))))


(define home-eww-service-type
  (service-type
    (name 'eww)
    (default-value #f)
    (extensions (list (service-extension
		       home-shepherd-service-type
		       home-eww-service)))
    (description "Manges the eww's daemon")))

;;; takes a list of strings to build the command
(define (home-eww-open-windows-service config)
  (list (shepherd-service
	  (provision '(eww-open-windows))
	  (requirement '(eww))
	  (one-shot? #t)
	  (respawn? #f)
	  (start #~(lambda _
		     (let ((status
			    (system* (string-append #$eww "/bin/eww")
				     "open-many"
				     "status"
				     "music"
				     "clock-window"
				     "workspaces"
				     "tray"
				     "nalug")))
		       (unless (zero? status)
			 (error "Failed to open eww's windows"))
		       #t))))))

(define home-eww-open-windows-service-type
  (service-type
    (name 'eww-open-windows)
    (default-value #f)
    (extensions (list (service-extension
		       home-shepherd-service-type
		       home-eww-open-windows-service)))
    (description "Opens all of eww's windows")))

;; dunst service
(define (home-dunst-service config)
  (list (shepherd-service
	  (provision '(dunst))
	  (requirement '(wayland-display))
	  (start #~ (lambda args
		      (apply
		       (make-forkexec-constructor
			(list (string-append
			       #$dunst
			       "/bin/dunst"))
			#:environment-variables (environ))
		       args)))
	  (stop #~(make-kill-destructor)))))


(define home-dunst-service-type
  (service-type
    (name 'dunst)
    (default-value #f)
    (extensions (list (service-extension
		       home-shepherd-service-type
		       home-dunst-service)))
    (description "Manages dunst, the notification daemon")))

(cond
 ;; ;; ;; Stardust (Tower PC)
 ((string= (gethostname) "stardust")
  (home-environment
    (packages (map specification->package (append fonts
						  clis
						  IM
						  sway-core
						  desktop-common
						  desktop-extra
						  desktop-portable
						  music
						  emacs-core
						  emacs-extra
						  dictionaries
						  zig
						  raku
						  raku-dev
						  latex-dev
						  perl
						  lisp-dev
						  cl
						  guile
						  emulators
						  development
						  flatpak-core
						  misc
						  multimedia-editing
						  games)))
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
	       `((".config/sway/config" ,(local-file "sway/stardust.config"))
		 (".config/emacs/Air4x.org" ,(local-file "emacs/Air4x.org"))
		 (".config/mpd/mpd.conf" ,(local-file "mpd/mpd.conf"))
		 (".config/dunst/dunstrc" ,(local-file "dunst/dunstrc"))
		 (".config/alacritty/alacritty.toml" ,(local-file "alacritty/alacritty.toml"))
		 ("Immagini/wallpaper.jpg" ,(local-file "yusei_stardust.jpg"))
		 ("Modelli/blog_article.org" ,(local-file "templates/blog_article.org"))
		 ;; recursive is set to true to mantain file permission
		 (".local/bin/orgzly-ignore" ,(local-file "scripts/orgzly-ignore" #:recursive? #t))
		 (".local/bin/note-capture-image" ,(local-file "scripts/note-capture-image" #:recursive? #t))
		 (".local/bin/wifi_menu" ,(local-file "scripts/wifi_menu" #:recursive? #t))
		 (".local/bin/yt-url" ,(local-file "scripts/yt-url" #:recursive? #t))
		 (".config/eww/cpu-average.pl" ,(local-file "eww/cpu-average.pl"#:recursive? #t))
		 (".config/eww/inet.sh" ,(local-file "eww/inet.sh" #:recursive? #t))
		 (".config/eww/meteo.pl" ,(local-file "eww/meteo.pl" #:recursive? #t))
		 (".config/eww/mpd-duration.pl" ,(local-file "eww/mpd-duration.pl" #:recursive? #t))
		 (".config/eww/mpd-get-image.pl" ,(local-file "eww/mpd-get-image.pl" #:recursive? #t))
		 (".config/eww/workspace.pl" ,(local-file "eww/workspace.pl" #:recursive? #t))
		 (".config/eww/nalug-status.sh" ,(local-file "eww/nalug-status.sh" #:recursive? #t))
		 (".config/eww/eww.yuck" ,(local-file "eww/eww.yuck"))
		 (".config/eww/eww.scss" ,(local-file "eww/eww.scss"))))
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
			    "F2FEFE669117674C003D55609BDFFC914D670025"))))
		       (channel
			 (name 'panther)
			 (url "https://codeberg.org/gofranz/panther")
			 (branch "master")
			 (introduction
			  (make-channel-introduction
			   "54b4056ac571611892c743b65f4c47dc298c49da"
			   (openpgp-fingerprint
			    "A36A D41E ECC7 A871 1003  5D24 524F EB1A 9D33 C9CB"))))
		       (channel
			 (name 'guix-gaming-games)
			 (url "https://gitlab.com/guix-gaming-channels/games.git")
			 ;; Enable signature verification:
			 (introduction
			  (make-channel-introduction
			   "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
			   (openpgp-fingerprint
			    "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))))
      (service home-dbus-service-type)
      (service home-syncthing-service-type)
      (service home-mpd-service-type)
      (service home-emacs-service-type)
      (service home-pipewire-service-type)
      (service home-wayland-service-type 360)
      (service home-eww-service-type)
      (service home-kdeconnect-service-type)
      (service home-dunst-service-type)
      (service home-eww-open-windows-service-type)))
    (transformation
     (options->transformation '((tune . "x86-64-v4"))
			      #:warn? #f))))
 ;; ;; ;; ;; Trishula (laptop Tuxedo)
 ((string= (gethostname) "trishula")
  (home-environment
    (packages (map specification->package
		   (append misc
			   fonts
			   clis
			   raku
			   sway-core
			   desktop-common
			   desktop-extra
			   desktop-portable
			   emacs-core
			   music
			   IM
			   lisp-dev
			   guile
			   '("nss-certs")
			   '("fontconfig"))))
    (services
     (list
      (service home-bash-service-type
	       (home-bash-configuration
		 (guix-defaults? #t)
		 (environment-variables '(("QT_QPA_PLATFORM" . "wayland")
					  ("PATH" . "$PATH:/home/mario/.local/bin/")
					  ("PATH" . "/home/mario/.guix-profile/bin/:$PATH")
					  ("XDG_CURRENT_DESKTOP" . "sway")))
		 (bashrc (list (local-file "bash/conf")))
		 (aliases '(("ls" . "eza")
			    ("la" . "eza -a")
			    ("ll" . "eza -al")
			    ("emc" . "emacsclient -nw")
			    ("wifi" . "nmcli d w")
			    ("connect" . "nmcli d w c")
			    ("spegni" . "shutdown now")))
		 (bash-profile (list (local-file "bash/profile.conf")))))
      (service home-files-service-type
	       `((".config/sway/config" ,(local-file "sway/trishula.config"))
		 (".config/emacs/Air4x.org" ,(local-file "emacs/trishula.org"))
		 (".config/mpd/mpd.conf" ,(local-file "mpd/trishula.conf"))
		 (".config/dunst/dunstrc" ,(local-file "dunst/dunstrc"))
		 (".config/waybar/config.jsonc" ,(local-file "waybar/trishula.jsonc"))
		 (".config/waybar/style.css" ,(local-file "waybar/trishula.css"))
		 (".config/alacritty/alacritty.toml" ,(local-file "alacritty/alacritty.toml"))
		 ("Immagini/wallpaper.jpg" ,(local-file "Trishula.jpg"))
		 ("Modelli/blog_article.org" ,(local-file "templates/blog_article.org"))
		 ;; recursive is set to true to mantain file permission
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
			    "F2FEFE669117674C003D55609BDFFC914D670025"))))
		       (channel
			 (name 'panther)
			 (url "https://codeberg.org/gofranz/panther")
			 (branch "master")
			 (introduction
			  (make-channel-introduction
			   "54b4056ac571611892c743b65f4c47dc298c49da"
			   (openpgp-fingerprint "A36A D41E ECC7 A871 1003  5D24 524F EB1A 9D33 C9CB"))))
		       (channel
			 (name 'guix-gaming-games)
			 (url "https://gitlab.com/guix-gaming-channels/games.git")
			 ;; Enable signature verification:
			 (introduction
			  (make-channel-introduction
			   "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
			   (openpgp-fingerprint
			    "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))))
      (service home-syncthing-service-type)
      (service home-mpd-service-type)
      (service home-wayland-service-type 360)
      (service home-emacs-service-type)
      (service home-kdeconnect-service-type)
      (service home-dunst-service-type))))))
