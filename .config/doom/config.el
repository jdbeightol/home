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
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dropbox/notes/")

;; set the default org roam directory
(setq org-roam-directory org-directory)

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

;; automatically log the time when a todo task was marked as complete
(setq org-log-done 'time)

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
        ("today" . ?t)
        ))

;; configure custom org mode todos
(after! org
  (setq
   org-todo-keywords '((sequence "TODO(t)" "HOLD(h)" "|" "DONE(d)" "PUNT(p)" "JIRA(j)"))
   org-todo-keyword-faces '(("HOLD" . +org-todo-onhold)
                            ("JIRA" . +org-todo-project)
                            ("PUNT" . +org-todo-cancel)
                            )
   ))

;; configure custom agenda views
(setq org-agenda-custom-commands
      '(("i" "Weekly Agenda and Important Tasks"
         ((agenda "" ((org-agenda-span 'week) (org-deadline-warning-days 7)))
          (tags-todo "+PRIORITY=\"A\"" ((org-agenda-overriding-header "Important Tasks")))))
        ("h" "Home Tasks" ((tags-todo "+home" ((org-agenda-overriding-header "Home Task List")))))
        ("u" "Untagged Tasks" ((tags-todo "-{.*}" ((org-agenda-overriding-header "Untagged Tasks")))))
        ("w" "Work Tasks" ((tags-todo "+work" ((org-agenda-overriding-header "Work Task List")))))
        ("n" "Work TODO Today"
         ((agenda "" ((org-agenda-span 'day) (org-deadline-warning-days 3)))
          (tags-todo "+today" ((org-agenda-overriding-header "Today's TODO List")))))
        ))

;; configure the default capture template for org-roam dailies
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %<%I:%M %p>: %?"
         :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n\n* Food\n| time | food    | calories | caffeine (mg) |\n|------+---------+----------+---------------|\n|      |         |          |               |\n|------+---------+----------+---------------|\n|      | *total* |          |               |\n#+TBLFM: @>$4=vsum(@2..@-1)::@>$3=vsum(@2..@-1)\n\n@zhathik\n")
         )))

;; disable the markdown mode in emacs everywhere; the text does not copy correctly
;; into windows when this is enabled
(setq emacs-everywhere-markdown-apps nil)
(setq emacs-everywhere-markdown-windows nil)

;; set up gptel configuration to use our local llama
(use-package! gptel
  :config
  (setq!
   gptel--system-message nil ;; this sets the default directive
   gptel-model 'gemma3:27b
   gptel-backend (gptel-make-ollama "ollama"
                   :host "llama.service.saturn.consul:80"
                   :stream t
                   :models '(
                             (llama3.2:3b
                              :description "Meta's Llama 3.2 goes small with 1B and 3B models."
                              :capabilities (tool-use))
                             (gemma3:27b
                              :description "The current, most capable model that runs on a single GPU."
                              :capabilities (media)
                              :mime-types ("image/jpeg" "image/png"))
                             (deepseek-r1:32b
                              :description "DeepSeek's first-generation of reasoning models with comparable performance to OpenAI-o1, including six dense models distilled from DeepSeek-R1 based on Llama and Qwen."
                              :capabilities (reasoning tool-use))
                             (devstral:24b
                              :description "Devstral: the best open source model for coding agents"
                              :capabilities (tool-use))
                             (mistral:7b
                              :description "The 7B model released by Mistral AI, updated to version 0.3."
                              :capabilities (tool-use))
                             )
                   )
   gptel-directives '(
                   (coding      . "you are a large language model and a careful programmer. provide code and only code as output without any additional text, prompt, or note.")
                   (emacs       . "you are a large language model living in emacs and a helpful assistant. respond concisely.")
                   (food        . "you are a calorie counter. estimate calories for meals where they're not specified and output the final sum. respond concisely with an org mode table. Only output the table, and never include code blocks or other org structures in your response.")
                   (programming . "You are an expert coding assistant. Your role is to provide high-quality code solutions, refactorings, and explanations.")
                   (writing     . "you are a large language model and a writing assistant. respond concisely.")
                   )
   gptel-use-context 'user
   ))

;; remove the default backeneds
(setf (gptel-get-backend "ChatGPT") nil)

(gptel-make-preset 'food
  :description "A preset calculating calories for food."
  :backend "ollama"
  :model 'gemma3:27b
  :system 'food
  :rewrite-message "Rewrite: fill in the missing values for calories and caffeine with your best estimates. Do not add any new rows to the table."
  :context--alist (list (list (concat org-roam-directory "20250615213619-calories.org"))))

(gptel-make-preset 'coding
  :description "A preset optimized for coding tasks"
  :backend "ollama"
  :model 'devstral:24b
  :system 'programming)

(gptel-make-preset 'zhathik
  :description "A roleplaying preset for adventure in Tamriel"
  :backend "ollama"
  :model 'llama3.2:3b
  :system "Your name is Zha'thik. You are a lusty argonian maid hoping to find her mate. You are extremly prejudice against Khajiit, of which you think I secretly am one.")

;; set some new keybindings to quickly access gptel features
(map! :leader
      (:prefix-map ("l" . "Llama")
        (:desc "Abort" "A" #'gptel-abort)
        (:desc "Add region or buffer to context" "a" #'gptel-add)
        (:desc "Open llama buffer" "b" #'gptel)
        (:desc "Add file to context" "f" #'gptel-add-file)
        (:desc "Send to llama" "l" #'gptel-send)
        (:desc "Regenerate response" "L" #'gptel--regenerate)
        (:desc "Open llama menu" "m" #'gptel-menu)
        (:desc "Mark the llama response" "M" #'gptel--mark-response)
        (:desc "Select a llama preset" "p" #'gptel--preset)
        (:desc "Save org mode properties" "P" #'gptel-org-set-properties)
        (:desc "Rewrite region with llama" "r" #'gptel-rewrite)
        (:desc "Set system prompt" "s" #'gptel-system-prompt)
        (:desc "Select llama tools" "t" #'gptel-tools)
        (:desc "Set org mode topic" "T" #'gptel-org-set-topic)
        ))

;; create a function to synchronize calendars that were downloaded from elsewhere
(defun icalendar-import-local-files ()
  "Syncronize calendars as defined in the user's ~/.local/calendars/ directory"
  (interactive)
  (let ((dir "~/.local/calendars/")
        (ext ".ics"))
    (progn
      (delete-file diary-file)
      (dolist (file (directory-files dir t))
        (if (string-match ext file)
            (icalendar-import-file file diary-file))))))
