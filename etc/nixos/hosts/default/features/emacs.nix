{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: with epkgs; [
      nix-mode
      nix-sandbox
      vterm
      catppuccin-theme
      hardcore-mode
      python-mode
      python-black
      lsp-mode
      lsp-ui
      doom-modeline
      all-the-icons
      treesit-grammars.with-all-grammars
      leerzeichen
      rainbow-delimiters
      which-key
      helpful
      editorconfig
      projectile
      magit
      company
      ace-window
      ivy
      swiper
      counsel
      counsel-projectile
      auto-virtualenv
      xclip
      rust-mode
      direnv
    ];
    extraConfig = ''
      ;; Remove GUI bloat
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (tooltip-mode -1)
      (menu-bar-mode -1)

      (xclip-mode 1)
      (direnv-mode)

      ;; Alert errors
      (setq visible-bell t)

      ;; Visual preferences:
      ;; - dark theme
      ;; - bottom padding
      ;; - font
      (load-theme 'catppuccin :no-confirm)
      (set-fringe-mode 10)
      (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font")
      (set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font")
      (set-face-attribute 'variable-pitch nil :font "Roboto" :weight 'regular)
      (window-divider-mode +1)
      (setq window-divider-default-right-width 2 window-divider-default-bottom-width 2)
      (doom-modeline-mode 1)

      (projectile-mode)
      (counsel-projectile-mode)
      (setq projectile-switch-project-action #'projectile-dired)
      (global-hardcore-mode)

      (setq vterm-max-scrollback 10000)

      (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
      (add-hook 'python-mode-hook 'lsp)
      (add-hook 'python-mode-hook 'python-black-on-save-mode)
      (add-hook 'rust-mode-hook 'lsp)
      (setq rust-format-on-save t)
      (add-hook 'prog-mode-hook (lambda ()
                                (whitespace-mode)
                                (line-number-mode)
                                (column-number-mode)
                                (setq display-line-numbers 'relative)
                                (setq whitespace-style '(face spaces space-mark tabs tab-mark trailing))
                                (setq whitespace-display-mappings
                                      '((tab-mark 9 [124 9] [92 9])
                                      (space-mark 32 [183] [46])
                                      (space-mark 160 [164] [95])
                                      (newline-mark 10 [36 10])))))

      ;; Flycheck
      (setq flycheck-command-wrapper-function
              (lambda (command) (apply 'nix-shell-command (nix-current-sandbox) command))
            flycheck-executable-find
              (lambda (cmd) (nix-executable-find (nix-current-sandbox) cmd)))

      ;; Keybindings
      (delete-selection-mode 1)
      (define-key key-translation-map [?\C-h] [?\C-?])
      (global-set-key [?\C-j] 'newline-and-indent)
      (global-set-key (kbd "M-x") 'counsel-M-x)
      (global-set-key (kbd "C-x C-f") 'counsel-find-file)
      (global-set-key (kbd "M-o") 'ace-window)
      (global-set-key (kbd "C-s") 'swiper)
      (global-set-key (kbd "C-r") 'swiper-backward)
      (global-set-key (kbd "C-c p") 'projectile-command-map)

      ;; Buffer stuff
      (recentf-mode 1)
      (savehist-mode 1)
      (winner-mode 1)
      (setq history-length 25)

      ;; Xclip config
      (setq xclip-program "wl-copy")
      (setq xclip-select-enable-clipboard t)
      (setq xclip-mode t)
      (setq xclip-method (quote wl-copy))
    '';
  };
}
