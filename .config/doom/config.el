;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'leuven)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dropbox/notes/")
;;
;; set the default org roam directory
(setq org-roam-directory "~/dropbox/notes/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; set emacs to quit without asking
(setq confirm-kill-emacs nil)

;; treat underscores as part of a word --especially when moving forward or back
;; a word at a time. This matches the behavior of vim and is especially useful
;; in languages like python.
(modify-syntax-entry ?_ "w")

;; Let's redefine the home and end keys to go to the beginning and end of lines
;; instead of the document. I always use gg and G to navigate through a document
;; anyway.
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)

;; remove smart parens
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; @see https://bitbucket.org/lyro/evil/issue/511/let-certain-minor-modes-key-bindings
(eval-after-load 'git-timemachine
  '(progn
     (evil-make-overriding-map git-timemachine-mode-map 'normal)
     ;; force update evil keymaps after git-timemachine-mode loaded
     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)
     ))

;; set the diary file
(setq diary-file (concat org-directory "diary"))

;; add all org, org-roam, and daily note files to the org-agenda by default.
;; this has the risk of being slow, so we may need to reconsider this.
(setq org-agenda-files (list org-directory (concat org-directory "daily/")))

;; ensure our diary entries show up in our org-agenda
;; we can regenerate the diary by manually downloading the ics file and running
;; the icalendar-import-file function
(setq org-agenda-include-diary t)

;; set the format for the agenda
(setq org-agenda-prefix-format '((agenda . " %i %?-12t% s")
                                (todo . " %i")
                                (tags . " %i")
                                (search . " %i")
                                ))

;; configure custom org mode tags
(setq org-tag-alist
      '(("home" . ?h)
        ("work" . ?w)
        ("project" . ?p)
        ("errand" . ?e)
        ))

;; configure custom org mode todos
(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "HOLD(h)" "|" "DONE(d)" "PUNT(p)" "JIRA(j)")))
  (setq org-todo-keyword-faces '(("HOLD" . +org-todo-onhold)
                               ("JIRA" . +org-todo-project)
                               ("PUNT" . +org-todo-cancel)
                               ))
  )


;; configure custom agenda views
(setq org-agenda-custom-commands
      '(("n" "Weekly Agenda and Important Tasks"
         ((agenda "" ((org-agenda-span 'week)
                      (org-deadline-warning-days 7)))
          (tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "High Priority Tasks")))))
        ("h" "Home Tasks" ((tags-todo "+home"
                     ((org-agenda-overriding-header "Home Task List")))))
        ("u" "Untagged Tasks" ((tags-todo "-{.*}"
                     ((org-agenda-overriding-header "Untagged Tasks")))))
        ("w" "Work Tasks" ((tags-todo "+work"
                     ((org-agenda-overriding-header "Work Task List")))))
        ))

;; set up gptel configuration to use our local llama
(setq
 gptel-model 'llama3.2:3b
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "llama.service.saturn.consul:80"
                 :stream t
                 :models '(llama3.1:8b llama3.2:3b llama3.3:70b phi4:14b gemma3:4b gemma3:12b mistral:7b mistral-nemo:12b llava:7b codellama:7b codellama:13b llama3.2-vision:11b exaone-deep:7.8b deepseek-r1:7b deepseek-r1:8b deepseek-r1:14b qwq:32b qwen2.5:7b qwen2.5:14b qwen2.5-coder:7b qwen2.5-coder:14b starcoder2:7b starcoder2:15b openthinker:7b hermes3:8b)
                 ))

;; custom directives we can use for our LLMs; let's leave the default empty to we get the default beahviors out of the model
(setq gptel-directives
      '((default     . "")
        (emacs       . "You are a large language model living in Emacs and a helpful assistant. Respond concisely.")
        (programming . "You are a large language model and a careful programmer. Provide code and only code as output without any additional text, prompt or note.")
        (writing     . "You are a large language model and a writing assistant. Respond concisely.")
        (chat        . "You are a large language model and a conversation partner. Respond concisely.")
        ))

;; set some new keybindings to quickly access gptel features
(map! :leader
      (:prefix-map ("l" . "Llama")
        (:desc "Abort" "A" #'gptel-abort)
        (:desc "Add region or buffer to context" "a" #'gptel-add)
        (:desc "Open llama buffer" "b" #'gptel)
        (:desc "Add file to context" "f" #'gptel-add-file)
        (:desc "Send to llama" "l" #'gptel-send)
        (:desc "Open llama menu" "m" #'gptel-menu)
        (:desc "Save org mode properties" "p" #'gptel-org-set-properties)
        (:desc "Rewrite region with llama" "r" #'gptel-rewrite)
        (:desc "Set system prompt" "s" #'gptel-system-prompt)
        (:desc "Set org mode topic" "t" #'gptel-org-set-topic)
        ))
