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
     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))

;; set up gptel configuration to use our local llama
(setq
 gptel-model 'llama3.2:3b
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "llama.service.saturn.consul:80"
                 :stream t
                 :models '(llama3.2:3b gemma3:4b mistral:7b llava:7b codellama:7b)
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
        (:desc "Open llama buffer" "b" #'gptel)
        (:desc "Send to llama" "l" #'gptel-send)
        (:desc "Rewrite region with llama" "r" #'gptel-rewrite)
        (:desc "Open llama menu" "m" #'gptel-menu)
        (:desc "Set org mode topic" "t" #'gptel-org-set-topic)
        (:desc "Save org mode properties" "p" #'gptel-org-set-properties)
      ))
