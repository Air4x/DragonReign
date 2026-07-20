(list (channel
       (name 'guix)
       (url "https://git.guix.gnu.org/guix.git")
       (branch "master")
       (commit "38031dd2c8b08bb21cc429f981a2ca843c205bd5")
       (introduction
        (make-channel-introduction
         "9edb3f66fd807b096b48283debdcddccfea34bad"
         (openpgp-fingerprint
          "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
       (name 'nonguix)
       (url "https://gitlab.com/nonguix/nonguix")
       (branch "master")
       (commit "d35a2f8f22023426ccf3598fa7079b09bb821e3e")
       (introduction
        (make-channel-introduction
         "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
         (openpgp-fingerprint
          "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
      (channel
       (name 'clocktower)
       (url "https://codeberg.org/TohsakaTypeclass/clocktower")
       (branch "master")
       (commit "6198d1cbd2adceb216718b6b12efca9993405079")
       (introduction
        (make-channel-introduction
         "9fb086fa9ee955c7daf755a5b114eedc030de99d"
         (openpgp-fingerprint
          "4B1E F810 76ED 1A25 D15C  CB18 4572 A777 FF18 DBCC"))))
      (channel
       (name 'boot-sector-launch)
       (url "https://github.com/Air4x/boot-sector-launch.git")
       (branch "master")
       (commit "264f324faa442a0842271a74556f59259ebf43f3")
       (introduction
        (make-channel-introduction
         "fb5c7f05324ec8228ea4e3ed3f0af7eda38a535d"
         (openpgp-fingerprint
          "F2FE FE66 9117 674C 003D  5560 9BDF FC91 4D67 0025")))))
