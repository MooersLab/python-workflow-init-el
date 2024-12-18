;; init.el --- Emacs configuration file for Python programming

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Language Server Protocol (LSP) support
(use-package lsp-mode
  :hook (python-mode . lsp)
  :commands lsp)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

;; Tree-sitter for syntax highlighting
(use-package tree-sitter
  :hook (python-mode . tree-sitter-mode)
  :config
  (use-package tree-sitter-langs))

;; Code snippets
(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)

;; Unit testing
(use-package python-pytest
  :commands (python-pytest-dispatch))

;; REPL
(use-package python
  :ensure nil
  :hook (python-mode . inferior-python-mode))

(use-package python-shell-interpreter
  :ensure nil
  :hook (python-mode . run-python))

;; Syntax highlighting
(use-package highlight-indent-guides
  :hook (python-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

;; Auto-completion
(use-package company
  :hook (python-mode . company-mode))

;; Linting
(use-package flycheck
  :hook (python-mode . flycheck-mode))

(use-package flycheck-pycheckers
  :hook (flycheck-mode . flycheck-pycheckers-setup))

;; Debugger tools
(use-package dap-mode
  :config
  (dap-ui-mode)
  (require 'dap-python)
  :hook (python-mode . dap-mode))

;; Version control integration with magit
(use-package magit
  :commands (magit-status))

;; Refactoring tools
(use-package python-black
  :demand t
  :after python)

(use-package isortify
  :hook (python-mode . isortify-mode))

;; Project management tools
(use-package projectile
  :config
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/projects"))
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

;; Documentation generation
(use-package sphinx-doc
  :hook (python-mode . sphinx-doc-mode))

;; Virtual environment management
(use-package pyvenv
  :config
  (pyvenv-mode 1))

;; Live code collaboration
(use-package teletype
  :hook (python-mode . teletype-mode))

;; Performance monitoring
(use-package esup
  :commands (esup))

;; Navigation
(use-package avy
  :bind ("C-:" . avy-goto-char))

(use-package ivy
  :config
  (ivy-mode 1))

;; Org-babel integration
(use-package ob-python
  :after org)

;; Spell check of docstrings
(use-package flyspell
  :hook (python-mode . flyspell-prog-mode))

;; Packaging into a module
(use-package package-lint
  :commands (package-lint-current-buffer))

