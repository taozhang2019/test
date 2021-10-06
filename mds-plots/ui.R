# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Somatic variant optimization by tuning gnomad AF"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(width = 2,
## action button for ploting    
      actionButton("makePlot",'Plot Data'),
      br(),
      br(),
## sample subset checkbox      
#      checkboxGroupInput(inputId ="sample_groups",
#                         label =  "Choose sample groups:",
#                         #                    choiceNames =
#                         list("1-10"=1, "11-20"=11, "21-30"=21, "31-40"=31, "41-50"=41, "51-60"=51, "61-70"=61, "71-80"=71, "81-90"=81, "91-100"=91),
#                         #                    choiceValues =
#                         #                      list("1",, "21", "31", "41", "51", "61", "71", "81", "91")
#      ),

# Input: Slider for gnomad AF filtering
      sliderInput(inputId = "gnomad_AF",
                  label = "gnomad allele frequency (-log10)",
                  min = 0.0,
                  max = 10.5,
                  value = 2.0
                  #                  animate=animationOptions(interval = 1000,loop=F) )   ,
      ),
      
# plot 12 Input: Slider for plot subgroup label 
      selectInput(inputId = "sub_group12",
                  label = "plot1&2 by subgroups of:",
                  choices = c("Variant_type", "MDS_recurrent_gene","COSMIC_variant", "Variant_source","All"),
                  selected = "MDS_recurrent_gene"),   
## plot 34 Input: Slider for plot subgroup label                    
#      selectInput(inputId = "sub_group34",
#                  label = "plot34 by subgroups of:",
#                  choices = c("Variant_type", "MDS_recurrent_gene","COSMIC_variant", "Variant_source","All"),
#                  selected = "MDS_recurrent_gene"),   
# plot 56 Input: Slider for plot subgroup label                      
      selectInput(inputId = "sub_group56",
                  label = "plot3&4&5 by subgroups of:",
                  choices = c("Variant_type", "MDS_recurrent_gene","COSMIC_variant", "Variant_source","All"),
                  selected = "Variant_type"),                                     
                  
# plot 12 zoom-in control                 
      textInput(inputId ="zoom_scale12", label = "plot1&2 zoom in scale", value = 10)   , #verbatimTextOutput("value"),
## plot 34 zoom-in control       
#      textInput(inputId ="zoom_scale34", label = "plot34 zoom in scale", value = 10), #verbatimTextOutput("value")  ,         

# plot 12 filtering setting       
      selectInput(inputId = "filter_group12",
                  label = "plot1&2 with groups filtered:",
                  choices = c("coding_variant", "COSMIC_variant", "MDS","MDS_coding","MDS_COSMIC","Variant_source","NA"),
                  selected = "COSMIC_variant"),
## plot 34 filtering setting     
#      selectInput(inputId = "filter_group34",
#                  label = "plot34 with groups filtered:",
#                  choices = c("coding_variant", "COSMIC_variant", "MDS","MDS_coding","MDS_COSMIC","NA"),
#                  selected = "coding_variant"),
# plot 56 filtering setting     
      selectInput(inputId = "filter_group56",
                  label = "plot3&4&5 with groups filtered:",
                  choices = c("coding_variant", "COSMIC_variant", "MDS","MDS_coding","MDS_COSMIC","Variant_source","NA"),
                  selected = "coding_variant") 
    ),
        
#    # Main panel for displaying outputs ----

    mainPanel(
#      plotOutput(outputId = "distPlot1"),
#      tableOutput(outputId = "disttable1")
#      verbatimTextOutput(outputId = "disttable1")    
#       Output: Histogram ----
      tabsetPanel(
          fluidRow(column(9,tabPanel("Plot",plotOutput("distPlot1"))), column(3,tabPanel("MDS_prognostic_gene_missing_summary",  verbatimTextOutput("disttable1"),offset = 1)    
  ))
))
))
