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
             (guix gexp))


(home-environment
  (packages (list htop
		  perl
		  sbcl
		  rakudo
		  mpd
		  mpd-mpc
		  coreutils
		  binutils))
  (services
   (append (list
            (service home-zsh-service-type
                     (home-zsh-configuration
                      (xdg-flavor? #f)
		      (environment-variables
		       '(("PROVA" . "Ciao, Guix")))))

            (simple-service 'test-config
                            home-xdg-configuration-files-service-type
                            (list `("test.conf"
                                    ,(plain-file "tmp-file.txt"
                                                 "the content of
                                          ~/.config/test.conf")))))
           %base-home-services)))
