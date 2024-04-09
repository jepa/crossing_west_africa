---
title: "Untitled"
author: "Juliano Palacios Abrantes"
date: "2024-04-09"
output: 
  html_document: 
    toc: yes
    keep_md: yes
---

# Script objective

This script extract the different data sources for straddling stocks identification and shifts for the West Africa region. In short this script follows these 4 steps:

1.- Define spatial boundaries for "West Africa"

2.- Extract transboundary species for the region from [Palacios-Abrantes et al., (2020)](https://www.nature.com/articles/s41598-020-74644-2)

3.- Extract shifts in these species' transboundary stocks according to [Palacios-Abrantes et al., 2022](https://onlinelibrary.wiley.com/doi/10.1111/gcb.16058)

4.- Extract shifts in these species' straddling stocks according to [Palacios-Abrantes et al., in prep]()




# 1.- Set spatial boundaries

## NOTES

- Western Sahara region is allocated to Morocco's Central EEZ
- Do we include the Canary Islands (Spain) and Madeira Isl. (Portugal)?


```r
# West african countries
wa_eez <- c("Senegal","Mauritania","Western Sahara","Morocco (Central)","Canary Isl. (Spain)","Madeira Isl. (Portugal)")
```


## 2.- Extract transboundary species for the region


```r
# Read species taxon info
taxon_inf <- my_data("sau_species")

# Read transboundary species database from Palacios-Abrantes et al 2020 (FishForVisa)
Transboundary_spp <- my_path("G", extra_path = "FishForVisa/Results/", name="Transboundary_spp.csv", read = TRUE)


wa_trans_spp <- Transboundary_spp %>% 
  filter(eez_name %in% wa_eez) %>% 
  left_join(taxon_inf) %>% 
  select(taxon_key,
         taxon_name,
         common_name,
         eez_name,
         eez_neighbour)
```

```
## Joining with `by = join_by(taxon_key)`
```

```r
write_csv(wa_trans_spp,
          my_path("D","species","wa_trans_spp.csv"))
```

### Summary of results

There are 149 species identified as transboundary in the region: 


```r
wa_trans_spp %>% 
  group_by(common_name,taxon_name) %>% 
  tally() %>% 
  knitr::kable(
    caption = "Transboundary species identified for the region. n = the number of times the species is shared (i.e., a proxy of stock)"
               )
```



Table: Transboundary species identified for the region. n = the number of times the species is shared (i.e., a proxy of stock)

|common_name                   |taxon_name                   |  n|
|:-----------------------------|:----------------------------|--:|
|African moonfish              |Selene dorsalis              |  4|
|Albacore                      |Thunnus alalunga             | 12|
|Alexandria pompano            |Alectis alexandrina          |  3|
|Atlantic bluefin tuna         |Thunnus thynnus              | 13|
|Atlantic bonito               |Sarda sarda                  | 15|
|Atlantic bumper               |Chloroscombrus chrysurus     |  4|
|Atlantic emperor              |Lethrinus atlanticus         |  3|
|Atlantic horse mackerel       |Trachurus trachurus          |  9|
|Atlantic pomfret              |Brama brama                  | 10|
|Atlantic sailfish             |Istiophorus albicans         | 14|
|Atlantic white marlin         |Kajikia albida               | 13|
|Axillary seabream             |Pagellus acarne              |  9|
|Basking shark                 |Cetorhinus maximus           | 10|
|Bastard grunt                 |Pomadasys incisus            |  5|
|Bearded brotula               |Brotula barbata              |  4|
|Benguela hake                 |Merluccius polli             |  1|
|Bigeye grunt                  |Brachydeuterus auritus       |  4|
|Bigeye thresher               |Alopias superciliosus        | 15|
|Bigeye tuna                   |Thunnus obesus               | 12|
|Biglip grunt                  |Plectorhinchus macrolepis    |  1|
|Black scabbardfish            |Aphanopus carbo              |  4|
|Black seabream                |Spondyliosoma cantharus      |  8|
|Blackbelly rosefish           |Helicolenus dactylopterus    |  8|
|Blackspot seabream            |Pagellus bogaraveo           |  5|
|Blue and red shrimp           |Aristeus antennatus          |  1|
|Blue butterfish               |Stromateus fiatola           |  4|
|Blue marlin                   |Makaira nigricans            | 12|
|Blue runner                   |Caranx crysos                |  2|
|Blue shark                    |Prionace glauca              | 13|
|Blue whiting                  |Micromesistius poutassou     |  2|
|Bluefish                      |Pomatomus saltatrix          |  5|
|Bluespotted seabream          |Pagrus caeruleostictus       |  4|
|Bobo croaker                  |Pseudotolithus elongatus     |  1|
|Boe drum                      |Pteroscion peli              |  1|
|Bogue                         |Boops boops                  |  9|
|Bonefish                      |Albula vulpes                |  4|
|Bonga shad                    |Ethmalosa fimbriata          |  4|
|Brown meagre                  |Sciaena umbra                |  2|
|Bullet tuna                   |Auxis rochei                 |  5|
|Canary drum                   |Umbrina canariensis          |  4|
|Caramote prawn                |Melicertus kerathurus        |  2|
|Cassava croaker               |Pseudotolithus senegalensis  |  4|
|Cobia                         |Rachycentron canadum         |  4|
|Comber                        |Serranus cabrilla            |  1|
|Common cuttlefish             |Sepia officinalis            |  9|
|Common dentex                 |Dentex dentex                |  2|
|Common dolphinfish            |Coryphaena hippurus          | 13|
|Common eagleray               |Myliobatis aquila            |  1|
|Common octopus                |Octopus vulgaris             |  9|
|Common pandora                |Pagellus erythrinus          |  4|
|Common sole                   |Solea solea                  |  5|
|Common stingray               |Dasyatis pastinaca           |  2|
|Common twobanded seabream     |Diplodus vulgaris            |  7|
|Crevalle jack                 |Caranx hippos                |  3|
|Cunene horse mackerel         |Trachurus trecae             |  3|
|Deepwater rose shrimp         |Parapenaeus longirostris     |  4|
|Dungat grouper                |Epinephelus goreensis        |  4|
|Dusky grouper                 |Epinephelus marginatus       |  7|
|Dusky shark                   |Carcharhinus obscurus        |  3|
|European anchovy              |Engraulis encrasicolus       |  9|
|European argentine            |Argentina sphyraena          |  1|
|European conger               |Conger conger                |  8|
|European hake                 |Merluccius merluccius        |  3|
|European lobster              |Homarus gammarus             |  2|
|European pilchard             |Sardina pilchardus           |  6|
|European seabass              |Dicentrarchus labrax         |  6|
|False scad                    |Caranx rhonchus              |  3|
|Flat needlefish               |Ablennes hians               |  4|
|Flathead grey mullet          |Mugil cephalus               |  3|
|Forkbeard                     |Phycis phycis                |  2|
|Frigate tuna                  |Auxis thazard                | 13|
|Giant African threadfin       |Polydactylus quadrifilis     |  1|
|Gilthead seabream             |Sparus aurata                | 10|
|Golden grey mullet            |Liza aurata                  |  4|
|Great barracuda               |Sphyraena barracuda          |  3|
|Great white shark             |Carcharodon carcharias       |  4|
|Greater amberjack             |Seriola dumerili             |  3|
|Greater forkbeard             |Phycis blennoides            |  1|
|Grey triggerfish              |Balistes capriscus           |  5|
|Grooved carpet shell          |Ruditapes decussatus         |  1|
|Guinean striped mojarra       |Gerres nigri                 |  1|
|Gulper shark                  |Centrophorus granulosus      |  1|
|John dory                     |Zeus faber                   |  5|
|Kitefin shark                 |Dalatias licha               |  3|
|Largeeye dentex               |Dentex macrophthalmus        |  8|
|Largehead hairtail            |Trichiurus lepturus          |  4|
|Law croaker                   |Pseudotolithus senegallus    |  1|
|Leafscale gulper shark        |Centrophorus squamosus       |  1|
|Leerfish                      |Lichia amia                  |  5|
|Lesser African threadfin      |Galeoides decadactylus       |  3|
|Little tunny                  |Euthynnus alletteratus       | 11|
|Longbill spearfish            |Tetrapturus pfluegeri        | 12|
|Longfin mako                  |Isurus paucus                | 13|
|Longspine snipefish           |Macroramphosus scolopax      |  4|
|Madeiran sardinella           |Sardinella maderensis        |  7|
|Meagre                        |Argyrosomus regius           |  5|
|Megrim                        |Lepidorhombus whiffiagonis   |  1|
|Norway lobster                |Nephrops norvegicus          |  2|
|Oceanic whitetip shark        |Carcharhinus longimanus      | 14|
|Oilfish                       |Ruvettus pretiosus           |  6|
|Opah                          |Lampris guttatus             |  1|
|Ornate wrasse                 |Thalassoma pavo              |  1|
|Pemarco blackfish             |Schedophilus pemarco         |  3|
|Plain bonito                  |Orcynopsis unicolor          |  5|
|Pompano                       |Trachinotus ovatus           |  1|
|Porbeagle                     |Lamna nasus                  |  8|
|Pouting                       |Trisopterus luscus           |  2|
|Queen scallop                 |Aequipecten opercularis      |  1|
|Red mullet                    |Mullus barbatus barbatus     |  2|
|Red pandora                   |Pagellus bellottii           |  4|
|Red porgy                     |Pagrus pagrus                |  9|
|Red scorpionfish              |Scorpaena scrofa             |  1|
|Redbanded seabream            |Pagrus auriga                |  1|
|Round sardinella              |Sardinella aurita            |  5|
|Royal threadfin               |Pentanemus quinquarius       |  2|
|Rubberlip grunt               |Plectorhinchus mediterraneus |  8|
|Saddled seabream              |Oblada melanura              |  6|
|Salema                        |Sarpa salpa                  |  5|
|Sand steenbras                |Lithognathus mormyrus        |  8|
|Sandbar shark                 |Carcharhinus plumbeus        | 11|
|Scalloped hammerhead          |Sphyrna lewini               | 15|
|Scarlet shrimp                |Plesiopenaeus edwardsianus   |  4|
|Senegalese hake               |Merluccius senegalensis      |  3|
|Shortfin mako                 |Isurus oxyrinchus            | 13|
|Shortspine African angler     |Lophius vaillanti            |  3|
|Silky shark                   |Carcharhinus falciformis     |  9|
|Silver scabbardfish           |Lepidopus caudatus           |  4|
|Silvery John dory             |Zenopsis conchifer           |  1|
|Skipjack tuna                 |Katsuwonus pelamis           | 14|
|Smooth hammerhead             |Sphyrna zygaena              | 10|
|Smooth-hound                  |Mustelus mustelus            |  6|
|Sompat grunt                  |Pomadasys jubelini           |  3|
|Southern pink shrimp          |Farfantepenaeus notialis     |  4|
|Spotted seabass               |Dicentrarchus punctatus      |  5|
|Surmullet                     |Mullus surmuletus            |  8|
|Swordfish                     |Xiphias gladius              | 13|
|Tarpon                        |Megalops atlanticus          |  1|
|Thresher                      |Alopias vulpinus             | 15|
|Tiger shark                   |Galeocerdo cuvier            |  7|
|Tope shark                    |Galeorhinus galeus           |  3|
|Wahoo                         |Acanthocybium solandri       |  3|
|Wedge sole                    |Dicologlossa cuneata         |  6|
|West African Spanish mackerel |Scomberomorus tritor         |  6|
|West African goatfish         |Pseudupeneus prayensis       |  5|
|West African ilisha           |Ilisha africana              |  3|
|White grouper                 |Epinephelus aeneus           |  4|
|White seabream                |Diplodus sargus sargus       |  3|
|Wreckfish                     |Polyprion americanus         |  8|
|Yellowfin tuna                |Thunnus albacares            | 12|

