# Define server logic required to draw a histogram ----
server <- function(input, output) {
  data(MDSdata6)
  removeModal()
  checkGnomad <- eventReactive(input$makePlot, {input$gnomad_AF})
  checkSub12 <- eventReactive(input$makePlot, {input$sub_group12})
  checkSub56 <- eventReactive(input$makePlot, {input$sub_group56})  
  checkZoom12 <- eventReactive(input$makePlot, {input$zoom_scale12})
  checkFilter12 <- eventReactive(input$makePlot, {input$filter_group12})
  checkfilter56 <- eventReactive(input$makePlot, {input$filter_group56})
                             
data_octopus_mds_new_tmp3<- reactive({
  print("#  select subset data ")              
    gnomad_AF <- checkGnomad()
    sub_group12 <- checkSub12()
    filter_group12 <- checkFilter12() 
    print("#  select column for subgroup in plot ")                                             
                                i=which(colnames(oct_all_2019_somatic)==input$sub_group12)
                                print("#  select gnomad AF cutoff for filtering data   ")                               
                                v=gnomad_AF
                                data_new3<-oct_all_2019_somatic[oct_all_2019_somatic$Genomad_AF_log>=v ,]
                                print("#  select column for filtering data    ")                              
                                f=filter_group12                               
                                if (f=="coding_variant")
                                {data_new3<-data_new3[data_new3$Variant_type!="noncoding_variant",c(2,3,i)]}   
                                else if (f=="COSMIC_variant")
                                {data_new3<-data_new3[data_new3$COSMIC_variant=="COSMIC",c(2,3,i)]}
                                else if (f=="MDS")
                                {data_new3<-data_new3[data_new3$MDS_recurrent_gene=="MDS",c(2,3,i)]}             
                                else if (f=="MDS_coding")
                                {data_new3<-data_new3[data_new3$MDS_recurrent_gene=="MDS" & data_new3$Variant_type!="noncoding_variant",c(2,3,i)]}     
                                else if (f=="MDS_COSMIC")
                                {data_new3<-data_new3[data_new3$MDS_recurrent_gene=="MDS" & data_new3$COSMIC_variant=="COSMIC",c(2,3,i)]} 
                                else if (f=="Variant_source")
                                {data_new3<-data_new3[data_new3$Variant_source=="PASS",c(2,3,i)]}                                                                                        
                                else
                                {data_new3<-data_new3[,c(2,3,i)]}   
                                print(data_new3[1:5,])
                                colnames(data_new3)<-c("value","value2","subgroup")
                                data_new3})
                                
print("# create dataframe object for gene sample plot") 
data_octopus_mds_new_tmp56<- reactive({
  print("#  select column for subgroup in plot  ")     
    gnomad_AF <- checkGnomad()
    sub_group56 <- checkSub56()
    filter_group56 <- checkfilter56()                                                                            
                                i=which(colnames(oct_all_2019_somatic_mds)==input$sub_group56)
                                print("#  select gnomad AF cutoff for filtering data  ")                                 
                                v=gnomad_AF
                                data_octopus_mds_new<-oct_all_2019_somatic_mds[oct_all_2019_somatic_mds$Genomad_AF_log>=v,]                              
                                print("#  select column for filtering data  ")  
                                f=filter_group56                                  
                                if (f=="coding_variant")
                                {data_octopus_mds_new<-data_octopus_mds_new[data_octopus_mds_new$Variant_type!="noncoding_variant",c(4,2,3,15,i)]}   
                                else if (f=="COSMIC_variant")
                                {data_octopus_mds_new<-data_octopus_mds_new[data_octopus_mds_new$COSMIC_variant=="COSMIC",c(4,2,3,15,i)]}
                                else if (f=="MDS")
                                {data_octopus_mds_new<-data_octopus_mds_new[data_octopus_mds_new$MDS_recurrent_gene=="MDS",c(4,2,3,15,i)]}             
                                else if (f=="MDS_coding")
                                {data_octopus_mds_new<-data_octopus_mds_new[data_octopus_mds_new$MDS_recurrent_gene=="MDS" & data_octopus_mds_new$Variant_type!="noncoding_variant",c(4,2,3,15,i)]}     
                                else if (f=="MDS_COSMIC")
                                {data_octopus_mds_new<-data_octopus_mds_new[data_octopus_mds_new$MDS_recurrent_gene=="MDS" & data_octopus_mds_new$COSMIC_variant=="COSMIC",c(4,2,3,15,i)]}    
                                else if (f=="Variant_source")
                                {data_octopus_mds_new<-data_octopus_mds_new[data_octopus_mds_new$Variant_source=="PASS",c(4,2,3,15,i)]}                           
                                else
                                {data_octopus_mds_new<-data_octopus_mds_new[,c(4,2,3,15,i)]}   
                                print(data_octopus_mds_new[1:5,])                                                                                                                           
                                colnames(data_octopus_mds_new)<-c("MDS_recurrent_gene","VAF","samples","All","subgroup") 
                                data_octopus_mds_new})
                          
                                                          
print("  # 2. Its output type is a plot") 
  output$distPlot1 <- renderPlot({
     zoom_scale12 <- checkZoom12() 
    filter_group12 <- checkFilter12() 
    filter_group56 <- checkfilter56()                                                                               

print("#  plot for variant/sample")   
                                data_new3<-data_octopus_mds_new_tmp3()    
                                print(dim(data_new3))
                                print(data_new3[1:5,])                                                                                                
print("#  select zoom scale ")                                
                                n=as.numeric(zoom_scale12)
print("#  select column for filtering data   ")                               
                                f=filter_group12                                                                                                                                                               
print("#  plot for variant/VAF")                                  
                                if ((n==0) & (f=="NA"))
                                {p5=ggplot( data_new3, aes(x=value, fill=subgroup)) +geom_histogram( alpha=0.6, position = 'dodge')+ xlab("Somatic variant VAF using mutect2/octopus") +ylab("Variant count")+xlim(0,1)
                                p6=ggplot( data_new3, aes(x=value2, fill=subgroup)) +geom_histogram(stat="count", alpha=0.6, position = 'stack')+ xlab("Samples  using mutect2/octopus") +ylab("Variant count")+ylim(0,49400)+scale_x_continuous(breaks = seq(1, m, by = 1))+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))}
                                else if ((n==0) & (f!="NA"))
                                {p5=ggplot( data_new3, aes(x=value, fill=subgroup)) +geom_histogram( alpha=0.6, position = 'dodge')+xlab("Somatic variant VAF using mutect2/octopus") +ylab("Variant count")+xlim(0,1)
                                p6=ggplot( data_new3, aes(x=value2, fill=subgroup)) +geom_histogram(stat="count", alpha=0.6, position = 'stack')+ xlab("Samples  using mutect2/octopus") +ylab("Variant count")+scale_x_continuous(breaks = seq(1, m, by = 1))+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))}   
                                else if (n!=0) 
                                {p5=ggplot( data_new3, aes(x=value, fill=subgroup)) +geom_histogram( alpha=0.6, position = 'dodge')+ xlab("Somatic variant VAF using mutect2/octopus") +ylab("Variant count")+xlim(0,1)+facet_zoom(ylim = c(0, n))
                                p6=ggplot( data_new3, aes(x=value2, fill=subgroup)) +geom_histogram(stat="count", alpha=0.6, position = 'stack')+ xlab("Samples  using mutect2/octopus") +ylab("Variant count")+facet_zoom(ylim = c(0, n))+scale_x_continuous(breaks = seq(1, m, by = 1)) +theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))}   
                                

# load dataframe for plot
                                data_octopus_mds_new<-data_octopus_mds_new_tmp56()
                                print(dim(data_octopus_mds_new))
                                print(data_octopus_mds_new[1:5,])                                
#  plot for gene/sample                                                             
                                p7=ggplot(data_octopus_mds_new,aes(x=reorder(MDS_recurrent_gene,All,sum), y=All,fill=subgroup)) +geom_bar(stat="identity")+ xlab("MDS_recurrent_gene_coding_variant_count_per_gene_in_494_MDS_patients") +ylab("variant_count") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))                             
#                                p7=ggplot( data_octopus_mds_new, aes(x=value, fill=subgroup)) +geom_histogram( alpha=0.6, position = 'stack',binwidth=0.5)+ xlab("494 Samples") +ylab("Variant count")+scale_x_continuous(breaks = seq(1, 501, by = 1))+ theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

                                p8=ggplot(data_octopus_mds_new,aes(x=reorder(MDS_recurrent_gene,VAF,mean), y=VAF,fill=subgroup))+geom_boxplot() +geom_dotplot(binaxis='y', stackdir='center',dotsize=0.2)+ xlab("MDS_recurrent_gene_in_494_MDS_patients") +ylab("VAF") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))  

#  table summary of gene / sample count
                                data_octopus_mds_new_st1<-as.data.frame(table(data_octopus_mds_new[,3]),stringsAsFactors = F)
                                print(dim(data_octopus_mds_new_st1)) 
                                print(data_octopus_mds_new_st1[1:5,])                                                              
                                data_octopus_mds_new_st2<-as.data.frame(table(data_octopus_mds_new_st1 [,2]),stringsAsFactors = F)
                                print(dim(data_octopus_mds_new_st2))                                 
                                colnames(data_octopus_mds_new_st2)<-c("MDS_recurrent_gene_coding_variant_count_per_sample","sample_count")
				                        ln<-dim(data_octopus_mds_new_st2)[1]
                                data_octopus_mds_new_st2[ln+1,1]<-0 
				                        data_octopus_mds_new_st2[ln+1,2]<-m-sum(data_octopus_mds_new_st2[1:ln,2])
                                #print(data_octopus_mds_new_st2)                                                                                                                                          
#  plot for gene/sample  
                                p9=ggplot(data_octopus_mds_new_st2,aes(x=reorder(MDS_recurrent_gene_coding_variant_count_per_sample,sample_count), y=sample_count)) +geom_bar(stat="identity")+ xlab("MDS_recurrent_gene_coding_variant_count_per_sample_in_494_MDS_patients") +ylab("sample_count")
                                 grid.arrange(p5, p6, p7, p8,p9, ncol=1)                                             
    } , height = 800, width = 900 )

#output$disttable1 <- renderDataTable({data_octopus_mds_new_tmp})
output$disttable1 <- renderPrint({data_octopus_mds_new<-data_octopus_mds_new_tmp56()                              
                                 MDS_missing=as.data.frame(MDS_gene[!(MDS_gene[,1] %in% data_octopus_mds_new[,1]),],stringasfactor=F)
                                 colnames(MDS_missing)<-'MDS_recurrent_gene_missed'
                                 MDS_missing
                                 })                                                                     
}
