shinyUI(
  fluidPage(
    
  # =========================================================================
  # Headtags
  # =========================================================================
    theme=shinytheme('journal'),  
    tags$head(
        HTML("<title>México: Covid-19 Tracker</title>"),
        tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
      ),
      
      sidebarLayout(
  # =========================================================================
  # Sidebar Panel
  # =========================================================================
        sidebarPanel(
          h1(span('COVID-19:', class = 'red_color'), span('MxTracker', class='yellow_color')),
          p(span('Última actualización:', class = 'font-weight-bold'), span(last_date_formated)),
          HTML("<p style = 'text-align: left;'><b>Fuente:</b> <a href='https://www.gob.mx/salud/documentos/informacion-internacional-y-nacional-sobre-nuevo-coronavirus-2019-ncov' target='_blank'>SSalud, Mx.</a>, a través de <a href='https://github.com/carranco-sga/Mexico-COVID-19' target='_blank'>carranco-sga</a>.<p/>"),
          hr(),
          
  # ***** INPUT: Date *****    
          fluidRow(
            column(12,
                   h3('Fecha'),
                   column(12,
                          dateInput(
                            inputId = 'pickDate',
                            label = 'Selecciona la fecha:',
                            value = last_date,
                            format = "dd/mm/yy",
                            language = 'es'
                          ),
                   ), 
                   class = 'col-md-7'),
            column(12,
                   htmlOutput('date_warning'),
                   class = 'col-md-5')
          ),
  
  # ***** INPUT: Plotline *****     
          fluidRow(
            column(12,
                 h3('Línea de Tiempo'),
                 column(12,
                    radioButtons("scale_log", 
                                 label = p("Selecciona la escala de visualización:"), 
                                 choices = list("Datos crudos" = 'raw', 
                                                "Escala Logarítmica" = 'log'),
                                 selected = 'raw'),
                    class='col-md-6'
                 ),
                 column(12,
                    checkboxGroupInput("case_categories", 
                         label = p("Categorías complementárias:"), 
                         choices = list("Casos Sospechosos" = 'Susp_rep', 
                                        "Casos Negativos" = 'Neg_rep',
                                        "Número de Pruebas Realizadas" = 'Tested_tot'),
                         selected = NULL),
                    class='col-md-6'
                 ),                 
              )
          ),
          hr(),
  
  # ***** Disclaimer *****       
          fluidRow(
            includeHTML('include_html/disclaimer.html')
          ), 
  # ***** Footer *****
          HTML("
  <p style = 'text-align: right;'>Author: <a href='https://github.com/jRicciL' target='_blank'>J. Ricci-López (2020) &copy;</a>, PhD student at <a href='https://www.cicese.edu.mx/' target='_blank'>CICESE</a>.<p/>
              "),
          width = 3,
          style = 'padding: 3rem'),
        
  # =========================================================================
  # Main Panel
  # =========================================================================
  
        mainPanel(
  # ***** Mexico Map and National Numbers *****   
          fluidRow(
            # =================
            # National Numbers
            # =================
            column(12, 
                   div(h3('Datos Nacionales',
                          class = 'text-center'),
                       style = 'margin-bottom: 0px; z-index: 100'),
                   hr(),
                   # ***** Date *****
                   fluidRow(
                     column(6,
                        h4('Fecha:'), class = "info_column_names"),
                     column(6,
                        fluidRow(
                          column(12,
                             h4(textOutput('text_date')),
                             class = "info_row_right"),
                          class='info_row')
                     ),
                     class = 'info_main_row'
                   ),
                   # ***** Positive Cases *****
                   fluidRow(
                     column(6,
                          h4('Número de CONFIRMADOS:'), 
                          class = "info_column_names"),
                     column(6,
                        fluidRow(
                          column(8,
                             h3(textOutput('text_pos')),
                             class = "info_row_right"),
                          column(4,
                             icon('fas fa-user-plus', 
                                  class = 'icon', lib = "font-awesome"),
                             class = "info_row_right"),
                          class='info_row positive_bg_color')
                     ),
                     class = 'info_main_row'
                   ),
                   # ***** Suspected Cases *****
                   fluidRow(
                     column(6,
                        h4('Número de SOSPECHOSOS:'), 
                        class = "info_column_names"),
                     column(6,
                        fluidRow(
                          column(8,
                             h3(textOutput('text_susp')),
                             class = "info_row_right"),
                          column(4,
                             icon('fas fa-user-clock', 
                                  class = 'icon', lib = "font-awesome"),
                             class = "info_row_right"),
                          class='info_row suspect_bg_color')
                     ),
                     class = 'info_main_row'
                   ),
                   # ***** Negative Cases *****
                   fluidRow(
                     column(6,
                        h4('Número de NEGATIVOS:'), 
                        class = "info_column_names"),
                     column(6,
                        fluidRow(
                          column(8,
                             h3(textOutput('text_neg')),
                             class = "info_row_right"),
                          column(4,
                             icon('fas fa-user-minus', 
                                  class = 'icon', lib = "font-awesome"),
                             class = "info_row_right"),
                          class='info_row negative_bg_color')
                     ),
                     class = 'info_main_row'
                   ),
                   # ***** Recovered Cases *****
                   fluidRow(
                     column(6,
                        h4('Número de RECUPERADOS:'), 
                        class = "info_column_names"),
                     column(6,
                        fluidRow(
                          column(8,
                             h3(textOutput('text_recov')),
                             class = "info_row_right"),
                          column(4,
                             icon('fas fa-user-shield', 
                                  class = 'icon', lib = "font-awesome"),
                             class = "info_row_right"),
                          class='info_row recovered_bg_color')
                     ),
                     class = 'info_main_row'
                   ),
                   # ***** Deceased Cases *****
                   fluidRow(
                     column(6,
                        h4('Número de DECESOS:'), 
                        class = "info_column_names"),
                     column(6,
                        fluidRow(
                          column(8,
                             h3(textOutput('text_deaths')),
                             class = "info_row_right"),
                          column(4,
                             icon('fas fa-cross', 
                                  class = 'icon', lib = "font-awesome"),
                             class = "info_row_right"),
                          class='info_row death_bg_color')
                     ),
                     class = 'info_main_row'
                   ),
                   # ***** Testing *****
                   fluidRow(
                     column(6,
                        h4('Número de pruebas realizadas:'), 
                        class = "info_column_names"),
                     column(6,
                        fluidRow(
                          column(8,
                             h3(textOutput('text_tested')),
                             class = "info_row_right"),
                          column(4,
                             icon('fas fa-vial', 
                                  class = 'icon', lib = "font-awesome"),
                             class = "info_row_right"),
                          class='info_row tested_bg_color')
                     ),
                     class = 'info_main_row'
                   ),
                class = "col-lg-4"),
            
            # =================
            # Mexico Map
            # =================
            column(12, 
               div(h3(
                      paste0('Número de casos confirmados por Estado'),
                      class = 'text-center'),
                   style = 'margin-bottom: 0px; z-index: 100'),
               leafletOutput(
                 outputId = 'mapMx',
                 height = "83%"
                 ),
               class = "col-lg-8",
               style = "height: 550px"
          ),
        ),
        
  # ***** Time Plot *****  
        fluidRow(
          column(12,
             div(h3('Linea de Tiempo: ',
                    span('Número de casos por día',
                         style = 'font-weight: normal;'),
                    class = 'text-center'),
                 style = 'margin-bottom: -35px; z-index: 1000'),
             withSpinner(plotlyOutput(
                          outputId = 'timePlot'))
          )
        ),
      width = 9)
    ),
    class='main_row_layout'
  )
)