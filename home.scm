(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
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
             (guix gexp))


(define base-packages
  (map specification->package '("coreutils"
				"binutils"
				"util-linux"
				"htop"
				"acpi")))

(define emacs-stuff
  (map specification->package '("emacs-pgtk"
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

(define fonts
  (map specification->package '("font-fira-code")))

(define scripting
  (map specification->package'("rakudo"
			       "perl"
			       "perl6-zef"
			       "cpan")))

(define programming
 (map specification->package '("sbcl"
			       "guile")))

(define music
 (map specification->package '("mpd"
			       "mpd-mpc"
			       "ncmpcpp")))

(define sway-stuff
  '("sway"
    "swayidle"
    "swaylock"
    "swaybg"
    "waybar"))


(define desktop
  (map specification->package (append sway-stuff '("tofi"
						   "cliphist"
						   "wl-clipboard"
						   "gammastep"
						   "grim"
						   "slurp"
						   "dunst"
						   "syncthing"))))
(define pkgs
  `(,@base-packages
    ,@emacs-stuff  
    ,@music        
    ,@scripting    
    ,@programming  
    ,@desktop))


(home-environment
 (packages pkgs)
 (services
  (list
   (service home-zsh-service-type))))
