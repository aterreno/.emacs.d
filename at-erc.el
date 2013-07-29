(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))

(setq erc-autojoin-channels-alist
          '(("irc.motech.net" "#general")))

(when (file-exists-p (concat dotfiles-dir ".erc-auth"))
  (load-file (concat dotfiles-dir ".erc-auth")))
