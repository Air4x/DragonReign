(use-modules (gnu)
	     (gnu home)
             (gnu home services)
             (gnu home services shells)
	     (gnu home services shepherd)
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
	     (gnu home services syncthing)
             (guix gexp))

(define pkgs
  (map specification->package '("font-fira-code"
				"font-nerd-fira-code"
				"font-et-book"
				"htop"
				"acpi"
				"sbcl"
				"guile"
				"tofi"
				"cliphist"
				"wl-clipboard"
				"grim"
				"slurp"
				"libadwaita"
				"hicolor-icon-theme"
				"dunst"
				"syncthing"
				"sway"
				"swayidle"
				"swaybg"
				"waybar"
				"foot"
				"mpd"
				"mpd-mpc"
				"ncmpcpp"
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
				"emacs-elpher")))

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
	     (guix-defaults? #t)))
   (service home-files-service-type
	    `((".config/sway/config" ,(local-file "sway/config"))
	      (".config/emacs/Air4x.org" ,(local-file "emacs/Air4x.org"))
	      (".config/mpd/mpd.conf" ,(local-file "mpd/mpd.conf"))
	      (".config/dunst/dunstrc" ,(local-file "dunst/dunstrc"))
	      (".config/waybar/config.jsonc" ,(local-file "waybar/config.jsonc"))
	      (".config/waybar/style.css" ,(local-file "waybar/style.css"))
	      ("Immagini/wallpaper.jpg" ,(local-file "ultimate-blue-eyes.jpg"))))
   (service home-syncthing-service-type)
   (service home-mpd-service-type)
   (service home-dunst-service-type)
   (service home-emacs-service-type))))
