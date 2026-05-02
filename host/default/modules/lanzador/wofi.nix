{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = "50%";
      height = "40%";
      location = "center";
      matching = "fuzzy";
      insensitive = true;
      layer = "overlay";
      gtk_dark = true;
      allow_markup = true;
      columns = 1;
      hide_scroll = true;
      close_on_focus_loss = true;
      animation = false;
      prompt = "Buscar:";
      show_search_icon = false;
    };
    # Estilo CSS completo
    style = ''

      /* Ventana principal - Panel de control industrial */
      window {
          margin: 0px;
          background-color: rgb(20, 20, 24);
          border-radius: 0px;
          font-family: "Liberation Mono", monospace; /* Corregido */
          font-size: 18px;
      }

      /* Barra superior - Estilo display industrial */
      #input {
          margin: 16px 16px 8px 16px;
          border: 1px solid #ffffff;
          background-color: #0a0a0c;
          color: #ffffff;
          border-radius: 5px;
          padding: 12px;
          font-family: monospace;
          font-size: 20px;
          caret-color: #ffffff;
      }

      /* Placeholder del input */
      #input:placeholder {
          color: #555;
      }

      /* Lista de resultados - Panel de selección */
      #entry {
          padding: 10px 16px;
          margin: 2px 12px;
          border-radius: 0px;
          border-left: 3px solid transparent;
          background-color: transparent;
          color: #cccccc;
          font-family: monospace;
      }

      /* Elemento seleccionado - Estilo industrial activo */
      #entry:selected {
          border-left: 4px solid #ffffff;
          border-radius: 0px;
          background-color: rgba(255, 255, 255, 0.1);
          color: #ffffff;
          box-shadow: inset 0 0 5px rgba(255, 255, 255, 0.08);
      }

      /* Efecto hover - Como botón industrial */
      #entry:hover {
          border-left: 3px solid #cccccc;
          background-color: rgba(255, 255, 255, 0.05);
      }

      /* Scrollbar - Estilo riel industrial */
      scrollbar {
          background-color: #1a1a1e;
          border-radius: 0px;
          width: 8px;
          margin: 4px;
      }

      scrollbar slider {
          background-color: rgba(255, 255, 255, 0.45);
          border-radius: 0px;
          min-height: 40px;
      }

      scrollbar slider:hover {
          background-color: #ffffff;
      }

      /* Ventana externa - Efecto de marco */
      window > box {
          margin: 4px;
          border: 1px solid #333;
      }

      /* Indicador de modo (opcional) */
      #mode-switch {
          color: #ffffff;
          font-size: 10px;
          padding: 4px 12px;
      }
    '';
  };
}