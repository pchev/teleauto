program TeleAuto;

{
Copyright (C) Philippe Martinole

http://www.teleauto.org/
philippe.martinole@teleauto.org

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}

uses
  Forms,
  pu_spy in 'pu_spy.pas' {pop_spy},
  u_math in 'u_math.pas',
  u_class in 'u_class.pas',
  u_constants in 'u_constants.pas',
  u_file_io in 'u_file_io.pas',
  u_general in 'u_general.pas',
  Catalogues in 'Catalogues.pas',
  pu_catalogs in 'pu_catalogs.pas' {pop_select_cat},
  pu_main in 'pu_main.pas' {pop_main},
  u_pretraitement in 'u_pretraitement.pas',
  pu_image in 'pu_image.pas' {pop_image},
  u_driver_st7_nt in 'u_driver_st7_nt.pas',
  pu_info_hdr in 'pu_info_hdr.pas' {pop_info_hdr},
  pu_about in 'pu_about.pas' {pop_about},
  pu_camera in 'pu_camera.pas' {pop_camera},
  pu_seuils in 'pu_seuils.pas' {pop_seuils},
  pu_scope in 'pu_scope.pas' {pop_scope},
  pu_splash in 'pu_splash.pas' {pop_splash},
  pu_clock in 'pu_clock.pas' {pop_clock},
  u_filtrage in 'u_filtrage.pas',
  pu_select_img in 'pu_select_img.pas' {pop_select_img},
  u_arithmetique in 'u_arithmetique.pas',
  pu_select_lot in 'pu_select_lot.pas' {pop_select_lot},
  pu_rapport in 'pu_rapport.pas' {pop_rapport},
  pu_conv_coord in 'pu_conv_coord.pas' {pop_conv_coord},
  pu_jour_julien in 'pu_jour_julien.pas' {pop_jour_julien},
  pu_map in 'pu_map.pas' {pop_map},
  u_geometrie in 'u_geometrie.pas',
  pu_dss in 'pu_dss.pas' {pop_dss},
  pu_vaisala in 'pu_vaisala.pas' {pop_vaisala},
  u_meca in 'u_meca.pas',
  u_modelisation in 'u_modelisation.pas',
  u_ephem in 'u_ephem.pas',
  u_driver_pisco in 'u_driver_pisco.pas',
  pu_seuils_color in 'pu_seuils_color.pas' {pop_seuils_color},
  pu_infos_image in 'pu_infos_image.pas' {pop_infos_image},
  pu_webcam in 'pu_webcam.pas' {pop_webcam},
  u_visu in 'u_visu.pas',
  u_analyse in 'u_analyse.pas',
  pu_conf in 'pu_conf.pas' {pop_conf},
  pu_script_builder in 'pu_script_builder.pas' {pop_builder},
  pu_filtre in 'pu_filtre.pas' {pop_filtre},
  pu_pretraitements in 'pu_pretraitements.pas' {pop_pretraitements},
  u_stream_prism in 'u_stream_prism.pas',
  u_lang in 'u_lang.pas',
  pu_choose_lang in 'pu_choose_lang.pas' {pop_choose_lang},
  pu_edit_dico in 'pu_edit_dico.pas' {pop_edit_dico},
  pu_dlg_standard in 'pu_dlg_standard.pas' {pop_dlg_standard},
  pu_occult in 'pu_occult.pas' {pop_occult},
  pu_blink in 'pu_blink.pas' {pop_blink},
  pu_choix_planete in 'pu_choix_planete.pas' {pop_choix_planet},
  pu_graph in 'pu_graph.pas' {pop_graphe},
  pu_ondelettes in 'pu_ondelettes.pas' {pop_ondelettes},
  pu_calibrate_track in 'pu_calibrate_track.pas' {pop_calibrate_track},
  pu_calib_Astrom in 'pu_calib_Astrom.pas' {pop_calib_astrom},
  pu_avi in 'pu_avi.pas' {pop_avi},
  u_focusers in 'u_focusers.pas',
  u_cameras in 'u_cameras.pas',
  pu_image_index in 'pu_image_index.pas' {pop_image_index},
  pu_dome in 'pu_dome.pas' {pop_dome},
  u_dome in 'u_dome.pas',
  u_telescopes in 'u_telescopes.pas',
  pu_camera_suivi in 'pu_camera_suivi.pas' {pop_camera_suivi},
  pu_histo in 'pu_histo.pas' {pop_histo},
  pu_clock_monitor in 'pu_clock_monitor.pas' {pop_clock_monitor},
  u_astrometrie in 'u_astrometrie.pas',
  pu_track in 'pu_track.pas' {pop_track},
  pu_dessin in 'pu_dessin.pas' {pop_dessin},
  pu_fit_astom in 'pu_fit_astom.pas' {pop_fit_astrom},
  pu_skychart in 'pu_skychart.pas' {pop_skychart},
  pu_profil2 in 'pu_profil2.pas' {pop_profil},
  u_porttalk in 'u_porttalk.pas',
  pu_create_prf in 'pu_create_prf.pas' {pop_create_prf},
  pu_edit_text in 'pu_edit_text.pas' {pop_edit_text},
  pu_pretraite_lot in 'pu_pretraite_lot.pas' {pop_pretraite_lot},
  u_hour_servers in 'u_hour_servers.pas',
  pu_hour_server in 'pu_hour_server.pas' {pop_hour_server},
  u_modele_pointage in 'u_modele_pointage.pas',
  pu_calib_modele in 'pu_calib_modele.pas' {pop_calib_modele},
  pu_anal_modele in 'pu_anal_modele.pas' {pop_anal_modele},
  pu_decalage_obs in 'pu_decalage_obs.pas' {pop_decalage_obs},
  pu_2integer_dlg in 'pu_2integer_dlg.pas' {pop_2integer_dlg},
  pu_anal_monture in 'pu_anal_monture.pas' {pop_anal_monture},
  pu_cree_proj in 'pu_cree_proj.pas' {pop_cree_proj},
  pu_obs_recurrente in 'pu_obs_recurrente.pas' {pop_obs_recurrente},
  pu_progression in 'pu_progression.pas' {pop_progression},
  pu_zoom in 'pu_zoom.pas' {pop_zoom},
  pu_map_monitor in 'pu_map_monitor.pas' {pop_map_monitor},
  u_Driver_ST7 in 'u_driver_st7.pas',
  pu_calib_cmde_corr in 'pu_calib_cmde_corr.pas' {pop_cmde_corr},
  u_bezier in 'u_bezier.pas',
  pu_cfadlg in 'pu_cfadlg.pas' {pop_cfadlg},
  pu_balance in 'pu_balance.pas' {pop_balance};

{$R *.RES}

// Mettre toutes le declarations des fenetres ici en commentaire
// Pour faciliter le mise a jour du modele de dictionnaire et
// des dictionnaires etrangers ( voir avec Philippe )
// A decommenter pour la traduction
{var
  pop_info_hdr:Tpop_info_hdr;
  pop_about:Tpop_about;
  pop_select_cat: Tpop_select_cat;
  pop_stats:Tpop_stats;
  pop_splash:Tpop_splash;
  pop_clock:Tpop_clock;
  pop_select_img:Tpop_select_img;
  pop_select_lot:Tpop_select_lot;
  pop_rapport:Tpop_rapport;
  pop_conv_coord:Tpop_conv_coord;
  pop_jour_julien:Tpop_jour_julien;
//  pop_map:Tpop_map; // ne pas mettre celui la !
  pop_objects:Tpop_objects;
  pop_2integer_dlg:Tpop_2integer_dlg;
  pop_dss:Tpop_dss;
  pop_criteria:Tpop_criteria;
  pop_vaisala:Tpop_vaisala;
  pop_date:Tpop_date;
  pop_script_constraints:Tpop_script_constraints;
  pop_obsauto_details:Tpop_obsauto_details;
  pop_init_scope:Tpop_init_scope;
  pop_infos_image:Tpop_infos_image;
  pop_webcam:Tpop_webcam;
  pop_conf:Tpop_conf;
  pop_builder:Tpop_builder;
  pop_filtre:Tpop_filtre;
  pop_pretraitements:Tpop_pretraitements;
  pop_dlg_standard:Tpop_dlg_standard;
  pop_image:Tpop_image;
  pop_choix_planet:Tpop_choix_planet;
  pop_blink:Tpop_blink;
  pop_graphe:Tpop_graphe;
  pop_addimage:Tpop_addimage;
  pop_avi: Tpop_avi;
  pop_calib_astrom: Tpop_calib_astrom;
  pop_calibrate_track:Tpop_calibrate_track;
  pop_choose_lang: Tpop_choose_lang;
  pop_clock_monitor: Tpop_clock_monitor;
  pop_combo: Tpop_combo;
  pop_create_prf: Tpop_create_prf;
  pop_dessin: Tpop_dessin;
  pop_edit_dico: Tpop_edit_dico;
  pop_edit_label: Tpop_edit_label;
  pop_expert:Tpop_expert;
  pop_fit_astrom: Tpop_fit_astrom;
  pop_histo: Tpop_histo;
  pop_image_comp: Tpop_image_comp;
  pop_image_index: Tpop_image_index;
  pop_imagedb: Tpop_imagedb;
  pop_occult: Tpop_occult;
  pop_ondelettes: Tpop_ondelettes;
  pop_profil:Tpop_profil;
  pop_skychart:Tpop_skychart;
//  pop_spy:Tpop_spy; // ne pas mettre celui la !
  pop_track:Tpop_track;
  pop_pretraite_lot:Tpop_pretraite_lot;
  pop_anal_modele:Tpop_anal_modele;
  pop_anal_monture:Tpop_anal_monture;
  pop_asterDB:Tpop_asterDB;
  pop_coord:Tpop_coord;
  pop_edit_text:Tpop_edit_text;
  pop_favorites:Tpop_favorites;
  pop_progression:Tpop_progression;
  pop_obs_recurrente:Tpop_obs_recurrente;
  pop_select_asteroid:Tpop_select_asteroid;
  pop_zoom:Tpop_zoom;
  pop_calib_modele:Tpop_calib_modele;
  pop_decalage_obs:Tpop_decalage_obs;
  pop_map_monitor:Tpop_map_monitor;
  pop_cfadlg:Tpop_cfadlg;
  pop_balance:Tpop_balance;
  pop_coupe:Tpop_coupe;}


begin
  TraductionEnCours:=False;
  Application.Initialize;
  outpop_Splash := Tpop_Splash.Create(Application);
  outpop_Splash.Show;
  outpop_Splash.Refresh;
  Application.Title := 'TeleAuto V4';
  Application.HelpFile := '';
//  A laisser absoluement ici car ces unités sont constament utilisés
//  Les autres unitées sont crées a chaque utilisation pour limiter la mémoire utilisée
//  Application.CreateForm(Tpop_main, pop_main);
//  Application.CreateForm(Tpop_spy, pop_spy);
//  Application.CreateForm(Tpop_seuils, pop_seuils);
//  Application.CreateForm(Tpop_seuils_color, pop_seuils_color);
//  Application.CreateForm(Tpop_camera, pop_camera);
//  Application.CreateForm(Tpop_scope, pop_scope);
//  Application.CreateForm(Tpop_map, pop_map);
//  Application.CreateForm(Tpop_dome, pop_dome);
//  Application.CreateForm(Tpop_camera_suivi, pop_camera_suivi);
//  Application.CreateForm(Tpop_hour_server, pop_hour_server);
//  .............................................
//  .............................................
//  .............................................
//  .............................................
//  .............................................
//  A completer .......
// pop_main toujours en premier sinon ca chie grâââââve !
  Application.CreateForm(Tpop_main, pop_main);
  Application.CreateForm(Tpop_spy, pop_spy);
  ReadInit; // Juste aprés pop_spy
  Application.CreateForm(Tpop_seuils, pop_seuils);
  Application.CreateForm(Tpop_seuils_color, pop_seuils_color);
  Application.CreateForm(Tpop_camera, pop_camera);
  Application.CreateForm(Tpop_scope, pop_scope);
  Application.CreateForm(Tpop_map, pop_map);
  Application.CreateForm(Tpop_dome, pop_dome);
  Application.CreateForm(Tpop_camera_suivi, pop_camera_suivi);
  Application.CreateForm(Tpop_image_index, pop_image_index);
  Application.CreateForm(Tpop_hour_server, pop_hour_server);
//  Application.CreateForm(Tpop_map_monitor, pop_map_monitor);
//  check_system;
  Application.CreateForm(Tpop_builder, pop_builder);

// A decommenter pour la traduction
{  TraductionEnCours:=True;
  pop_spy.Show;
  pop_seuils.Show;
  pop_seuils_color.Show;
  pop_camera.Show;
  pop_scope.Show;
  pop_map.Show;
  pop_dome.Show;
  pop_camera_suivi.Show;
  pop_image_index.Show;
  pop_hour_server.Show;
  pop_stats.Show;
  pop_builder.Show;
  pop_objects.Show;

  pop_spy.Top:=700;
  pop_seuils.Top:=700;
  pop_seuils_color.Top:=700;
  pop_camera.Top:=700;
  pop_scope.Top:=700;
  pop_map.Top:=700;
  pop_dome.Top:=700;
  pop_camera_suivi.Top:=700;
  pop_image_index.Top:=700;
  pop_hour_server.Top:=700;
  pop_stats.Top:=700;
  pop_builder.Top:=700;
  pop_objects.Top:=700;

  Application.CreateForm(Tpop_info_hdr, pop_info_hdr);
  pop_info_hdr.Show;
  pop_info_hdr.Top:=700;
  Application.CreateForm(Tpop_about, pop_about);
  pop_about.Show;  // Laisser absoluement
  pop_about.Top:=700;
  Application.CreateForm(Tpop_select_cat, pop_select_cat);
  pop_select_cat.Show;
  pop_select_cat.Top:=700;
  Application.CreateForm(Tpop_clock, pop_clock);
  pop_clock.Show;
  pop_clock.Top:=700;
  Application.CreateForm(Tpop_select_img, pop_select_img);
  pop_select_img.Show;
  pop_select_img.Top:=700;
  Application.CreateForm(Tpop_select_lot, pop_select_lot);
  pop_select_lot.Show;
  pop_select_lot.Top:=700;
  Application.CreateForm(Tpop_rapport, pop_rapport);
  pop_rapport.Show;
  pop_rapport.Top:=700;
  Application.CreateForm(Tpop_conv_coord, pop_conv_coord);
  pop_conv_coord.Show;
  pop_conv_coord.Top:=700;
  Application.CreateForm(Tpop_jour_julien, pop_jour_julien);
  pop_jour_julien.Show;
  pop_jour_julien.Top:=700;
  Application.CreateForm(Tpop_2integer_dlg, pop_2integer_dlg);
  pop_2integer_dlg.Show;
  pop_2integer_dlg.Top:=700;
  Application.CreateForm(Tpop_dss, pop_dss);
  pop_dss.Show;
  pop_dss.Top:=700;
  Application.CreateForm(Tpop_criteria, pop_criteria);
  pop_criteria.Show;
  pop_criteria.Top:=700;
  Application.CreateForm(Tpop_vaisala, pop_vaisala);
  pop_vaisala.Show;
  pop_vaisala.Top:=700;
  Application.CreateForm(Tpop_date, pop_date);
  pop_date.Show;
  pop_date.Top:=700;
  Application.CreateForm(Tpop_script_constraints, pop_script_constraints);
  pop_script_constraints.Show;
  pop_script_constraints.Top:=700;
  Application.CreateForm(Tpop_obsauto_details, pop_obsauto_details);
  pop_obsauto_details.Show;
  pop_obsauto_details.Top:=700;
  Application.CreateForm(Tpop_init_scope, pop_init_scope);
  pop_init_scope.Show;
  pop_init_scope.Top:=700;
  Application.CreateForm(Tpop_infos_image, pop_infos_image);
  pop_infos_image.Show;
  pop_infos_image.Top:=700;
  Application.CreateForm(Tpop_webcam, pop_webcam);
  pop_webcam.Show;
  pop_webcam.Top:=700;
  Application.CreateForm(Tpop_conf, pop_conf);
  pop_conf.Show;
  pop_conf.Top:=700;
  Application.CreateForm(Tpop_filtre, pop_filtre);
  pop_filtre.Show;
  pop_filtre.Top:=700;
  Application.CreateForm(Tpop_pretraitements, pop_pretraitements);
  pop_pretraitements.Show;
  pop_pretraitements.Top:=700;
  Application.CreateForm(Tpop_dlg_standard, pop_dlg_standard);
  pop_dlg_standard.Show;
  pop_dlg_standard.Top:=700;
  Application.CreateForm(Tpop_image, pop_image);
  pop_image.Show;
  pop_image.Top:=700;
  Application.CreateForm(Tpop_choix_planet, pop_choix_planet);
  pop_choix_planet.Show;
  pop_choix_planet.Top:=700;
  Application.CreateForm(Tpop_blink, pop_blink);
  pop_blink.Show;
  pop_blink.Top:=700;
  Application.CreateForm(Tpop_graphe, pop_graphe);
  pop_graphe.Show;
  pop_graphe.Top:=700;
  Application.CreateForm(Tpop_addimage, pop_addimage);
  pop_addimage.Show;
  pop_addimage.Top:=700;
  Application.CreateForm(Tpop_avi, pop_avi);
  pop_avi.Show;
  pop_avi.Top:=700;
  Application.CreateForm(Tpop_calib_astrom, pop_calib_astrom);
  pop_calib_astrom.Show;
  pop_calib_astrom.Top:=700;
  Application.CreateForm(Tpop_calibrate_track, pop_calibrate_track);
  pop_calibrate_track.Show;
  pop_calibrate_track.Top:=700;
  Application.CreateForm(Tpop_choose_lang, pop_choose_lang);
  pop_choose_lang.Show;
  pop_choose_lang.Top:=700;
  Application.CreateForm(Tpop_clock_monitor, pop_clock_monitor);
  pop_clock_monitor.Show;
  pop_clock_monitor.Top:=700;
  Application.CreateForm(Tpop_combo, pop_combo);
  pop_combo.Show;
  pop_combo.Top:=700;
  Application.CreateForm(Tpop_create_prf, pop_create_prf);
  pop_create_prf.Show;
  pop_create_prf.Top:=700;
  Application.CreateForm(Tpop_dessin, pop_dessin);
  pop_dessin.Show;
  pop_dessin.Top:=700;
  Application.CreateForm(Tpop_edit_dico, pop_edit_dico);
  pop_edit_dico.Show;
  pop_edit_dico.Top:=700;
  Application.CreateForm(Tpop_edit_label, pop_edit_label);
  pop_edit_label.Show;
  pop_edit_label.Top:=700;
  Application.CreateForm(Tpop_expert, pop_expert);
  pop_expert.Show;
  pop_expert.Top:=700;
  Application.CreateForm(Tpop_fit_astrom, pop_fit_astrom);
  pop_fit_astrom.Show;
  pop_fit_astrom.Top:=700;
  Application.CreateForm(Tpop_histo, pop_histo);
  pop_histo.Show;
  pop_histo.Top:=700;
  Application.CreateForm(Tpop_image_comp, pop_image_comp);
  pop_image_comp.Show;
  pop_image_comp.Top:=700;
  Application.CreateForm(Tpop_imagedb, pop_imagedb);
  pop_imagedb.Show;
  pop_imagedb.Top:=700;
  Application.CreateForm(Tpop_occult, pop_occult);
  pop_occult.Show;
  pop_occult.Top:=700;
  Application.CreateForm(Tpop_ondelettes, pop_ondelettes);
  pop_ondelettes.Show;
  pop_ondelettes.Top:=700;
  Application.CreateForm(Tpop_profil, pop_profil);
  pop_profil.Show;
  pop_profil.Top:=700;
  Application.CreateForm(Tpop_skychart, pop_skychart);
  pop_skychart.Show;
  pop_skychart.Top:=700;
  Application.CreateForm(Tpop_track, pop_track);
  pop_track.Show;
  pop_track.Top:=700;
  Application.CreateForm(Tpop_anal_modele, pop_anal_modele);
  pop_anal_modele.Show;
  pop_anal_modele.Top:=700;
  Application.CreateForm(Tpop_anal_monture, pop_anal_monture);
  pop_anal_monture.Show;
  pop_anal_monture.Top:=700;
  Application.CreateForm(Tpop_asterDB, pop_asterDB);
  pop_asterDB.Show;
  pop_asterDB.Top:=700;
  Application.CreateForm(Tpop_coord, pop_coord);
  pop_coord.Show;
  pop_coord.Top:=700;
  Application.CreateForm(Tpop_cree_proj, pop_cree_proj);
  pop_cree_proj.Show;
  pop_cree_proj.Top:=700;
  Application.CreateForm(Tpop_edit_text, pop_edit_text);
  pop_edit_text.Show;
  pop_edit_text.Top:=700;
  Application.CreateForm(Tpop_favorites, pop_favorites);
  pop_favorites.Show;
  pop_favorites.Top:=700;
  Application.CreateForm(Tpop_obs_recurrente, pop_obs_recurrente);
  pop_obs_recurrente.Show;
  pop_obs_recurrente.Top:=700;
  Application.CreateForm(Tpop_pretraite_lot, pop_pretraite_lot);
  pop_pretraite_lot.Show;
  pop_pretraite_lot.Top:=700;
  Application.CreateForm(Tpop_progression, pop_progression);
  pop_progression.Show;
  pop_progression.Top:=700;
  Application.CreateForm(Tpop_select_asteroid, pop_select_asteroid);
  pop_select_asteroid.Show;
  pop_select_asteroid.Top:=700;
  Application.CreateForm(Tpop_skychart_bar, pop_skychart_bar);
  pop_skychart_bar.Show;
  pop_skychart_bar.Top:=700;
  Application.CreateForm(Tpop_zoom, pop_zoom);
  pop_zoom.Show;
  pop_zoom.Top:=700;
  Application.CreateForm(Tpop_calib_modele, pop_calib_modele);
  pop_calib_modele.Show;
  pop_calib_modele.Top:=700;
  Application.CreateForm(Tpop_decalage_obs, pop_decalage_obs);
  pop_decalage_obs.Show;
  pop_decalage_obs.Top:=700;
  Application.CreateForm(Tpop_map_monitor, pop_map_monitor);
  pop_map_monitor.Show;
  pop_map_monitor.Top:=700;
  Application.CreateForm(Tpop_cfadlg, pop_cfadlg);
  pop_map_cfadlg.Show;
  pop_map_cfadlg.Top:=700;
  Application.CreateForm(Tpop_balance, pop_balance);
  pop_map_balance.Show;
  pop_map_balance.Top:=700;
  Application.CreateForm(Tpop_coupe, pop_coupe);
  pop_map_coupe.Show;
  pop_map_coupe.Top:=700;}


  Application.Run;
end.
