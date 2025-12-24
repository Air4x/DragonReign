(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
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
  '(coreutils
    binutils
    util-linux
    htop
    acpi))

(define emacs-stuff
  '(emacs-pgtk
    emacs-telega
    emacs-raku-mode
    emacs-slime
    emacs-all-the-icons
    emacs-ligature
    emacs-mixed-pitch
    emacs-consult
    emacs-vertico
    emacs-marginalia
    emacs-orderless
    emacs-embark
    emacs-org
    emacs-jinx
    emacs-olivetti
    emacs-org-roam
    emacs-org-contacts
    emacs-gnuplot
    emacs-org-bullets
    emacs-org-appear
    emacs-htmlize
    emacs-pdf-tools
    emacs-org-tree-slide
    emacs-eat
    emacs-yasnippet
    emacs-yasnippet-snippets
    emacs-paredit
    emacs-rainbow-delimeters
    emacs-geiser
    emacs-geiser-guile
    emacs-corfu
    emacs-cape
    emacs-magit
    emacs-auctex
    emacs-elpher))

(define fonts
  '(font-fira-code))

(define scripting
  '(rakudo
    perl
    zef
    cpan))

(define programming
  '(sbcl
    guile))

(define music
  '(mpd
    mpd-mpc
    ncmpcpp))

(define sway-stuff
  '(sway
    swayidle
    swaylock
    swaybg
    waybar))


(define desktop
  (append sway-stuff '(tofi
		       cliphist
		       wl-clipboard
		       gammastep
		       grim
		       slurp
		       dunst
		       syncthing)))

(home-environment
 (packages (append base-packages
		   emacs-stuff
		   music
		   scripting
		   programming
		   desktop))
 (services
  (list
   (service home-zsh-service-type))))
