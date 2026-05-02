# walker.nix
{ config, lib, pkgs, ... }:

{
  programs.walker = {
    enable = true;
    runAsService = true; # Nota: solo funciona en home-manager

    config = {
      theme = "matheme";
      placeholders."default" = { input = "Search"; list = "Example"; };
      elephant.install = [ "bluetooth" ];
      providers.prefixes = [
        { provider = "websearch"; prefix = "+"; }
        { provider = "providerlist"; prefix = "_"; }
        { provider = "bluetooth"; prefix = "bt"; }
      ];
      keybinds.quick_activate = [];
      hide_action_hints = true;
    };

    themes = {
      "matheme" = {
        style = ''
          @import url("colors-wallust.css");
          @define-color window_bg_color #1c1c1c;
          @define-color accent_bg_color @color12;
          @define-color theme_fg_color #ffffff;
          @define-color error_bg_color #C34043;
          @define-color error_fg_color #DCD7BA;

          /* Reset all styles */
          * {
              all: unset;
          }

          /* Window wrapper */
          .box-wrapper {
              background: @window_bg_color;
              padding: 20px;
              border-radius: 10px;
              border: 2px solid @window_bg_color;
          }

          /* Input field */
          .input {
              caret-color: @theme_fg_color;
              background: lighter(@window_bg_color);
              padding: 10px;
              color: @theme_fg_color;
              border-radius: 5px;
          }

          .input placeholder {
              opacity: 0.5;
          }

          /* List items */
          .list {
              color: @theme_fg_color;
          }

          .item-box {
              border-radius: 5px;
              padding: 10px;
          }

          child:hover .item-box,
          child:selected .item-box {
              background: alpha(@accent_bg_color, 0.25);
          }

          .item-text {
              font-size: 14px;
          }

          .item-subtext {
              font-size: 12px;
              opacity: 0.5;
          }

          .item-image,
          .item-image-text {
              margin-right: 10px;
          }

          /* Placeholders */
          .placeholder,
          .elephant-hint {
              color: @theme_fg_color;
              opacity: 0.5;
          }

          /* Keybinds display */
          .keybinds-wrapper {
              border-top: 1px solid lighter(@window_bg_color);
              font-size: 12px;
              opacity: 0.5;
              color: @theme_fg_color;
          }

          .keybind-bind {
              font-weight: bold;
              text-transform: lowercase;
          }

          /* Error display */
          .error {
              padding: 10px;
              background: @error_bg_color;
              color: @error_fg_color;
              border-radius: 5px;
          }

          /* Preview pane */
          .preview {
              border: 1px solid alpha(@accent_bg_color, 0.25);
              padding: 10px;
              border-radius: 10px;
              color: @theme_fg_color;
          }

          /* Icon sizes */
          .normal-icons {
              -gtk-icon-size: 16px;
          }

          .large-icons {
              -gtk-icon-size: 32px;
          }
        '';

        layouts = {
          layout = ''
            <?xml version="1.0" encoding="UTF-8" ?>
            <interface>
              <requires lib="gtk" version="4.0" />
              <object class="GtkWindow" id="Window">
                <style>
                  <class name="window" />
                </style>
                <property name="resizable">true</property>
                <property name="title">Walker</property>
                <child>
                  <object class="GtkBox" id="BoxWrapper">
                    <style>
                      <class name="box-wrapper" />
                    </style>
                    <property name="overflow">hidden</property>
                    <property name="orientation">horizontal</property>
                    <property name="valign">center</property>
                    <property name="halign">center</property>
                    <property name="width-request">600</property>
                    <property name="height-request">350</property>
                    <child>
                      <object class="GtkBox" id="Box">
                        <style>
                          <class name="box" />
                        </style>
                        <property name="orientation">vertical</property>
                        <property name="hexpand-set">true</property>
                        <property name="hexpand">true</property>
                        <property name="spacing">10</property>
                        <child>
                          <object class="GtkBox" id="SearchContainer">
                            <style>
                              <class name="search-container" />
                            </style>
                            <property name="overflow">hidden</property>
                            <property name="orientation">horizontal</property>
                            <property name="halign">fill</property>
                            <property name="hexpand-set">true</property>
                            <property name="hexpand">true</property>
                            <child>
                              <object class="GtkEntry" id="Input">
                                <style>
                                  <class name="input" />
                                </style>
                                <property name="halign">fill</property>
                                <property name="hexpand-set">true</property>
                                <property name="hexpand">true</property>
                              </object>
                            </child>
                          </object>
                        </child>
                        <child>
                          <object class="GtkBox" id="ContentContainer">
                            <style>
                              <class name="content-container" />
                            </style>
                            <property name="orientation">horizontal</property>
                            <property name="spacing">10</property>
                            <child>
                              <object class="GtkLabel" id="ElephantHint">
                                <style>
                                  <class name="elephant-hint" />
                                </style>
                                <property name="label">Waiting for elephant...</property>
                                <property name="hexpand">true</property>
                                <property name="vexpand">true</property>
                                <property name="visible">false</property>
                                <property name="valign">0.5</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkLabel" id="Placeholder">
                                <style>
                                  <class name="placeholder" />
                                </style>
                                <property name="label">No Results</property>
                                <property name="hexpand">true</property>
                                <property name="vexpand">true</property>
                                <property name="valign">0.5</property>
                              </object>
                            </child>
                            <child>
                              <object class="GtkScrolledWindow" id="Scroll">
                                <style>
                                  <class name="scroll" />
                                </style>
                                <property name="can_focus">false</property>
                                <property name="overlay-scrolling">true</property>
                                <property name="hexpand">true</property>
                                <property name="vexpand">true</property>
                                <property name="max-content-width">500</property>
                                <property name="min-content-width">500</property>
                                <property name="max-content-height">300</property>
                                <property name="propagate-natural-height">false</property>
                                <property name="propagate-natural-width">true</property>
                                <property name="hscrollbar-policy">automatic</property>
                                <property name="vscrollbar-policy">automatic</property>
                                <child>
                                  <object class="GtkGridView" id="List">
                                    <style>
                                      <class name="list" />
                                    </style>
                                    <property name="max_columns">1</property>
                                    <property name="min_columns">1</property>
                                    <property name="can_focus">false</property>
                                  </object>
                                </child>
                              </object>
                            </child>
                            <child>
                              <object class="GtkBox" id="Preview">
                                <style>
                                  <class name="preview" />
                                </style>
                              </object>
                            </child>
                          </object>
                        </child>
                        <child>
                          <object class="GtkBox" id="Keybinds">
                            <property name="hexpand">true</property>
                            <property name="margin-top">10</property>
                            <style>
                              <class name="keybinds" />
                            </style>
                            <child>
                              <object class="GtkBox" id="GlobalKeybinds">
                                <property name="spacing">10</property>
                                <style>
                                  <class name="global-keybinds" />
                                </style>
                              </object>
                            </child>
                            <child>
                              <object class="GtkBox" id="ItemKeybinds">
                                <property name="hexpand">true</property>
                                <property name="halign">end</property>
                                <property name="spacing">10</property>
                                <style>
                                  <class name="item-keybinds" />
                                </style>
                              </object>
                            </child>
                          </object>
                        </child>
                        <child>
                          <object class="GtkLabel" id="Error">
                            <style>
                              <class name="error" />
                            </style>
                            <property name="xalign">0</property>
                            <property name="visible">false</property>
                          </object>
                        </child>
                      </object>
                    </child>
                  </object>
                </child>
              </object>
            </interface>
          '';
          item_calc = " <!-- xml --> ";
        };
      };
      # Eliminamos el tema vacío "other theme name" para evitar errores
      # Si quieres otro tema, defínelo correctamente.
    };
  };
}
