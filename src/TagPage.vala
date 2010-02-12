/* Copyright 2010 Yorba Foundation
 *
 * This software is licensed under the GNU Lesser General Public License
 * (version 2.1 or later).  See the COPYING file in this distribution. 
 */

public class TagPage : CollectionPage {
    private Tag tag;
    
    public TagPage(Tag tag) {
        base (tag.get_name(), "tags.ui", create_actions());
        
        this.tag = tag;
        
        tag.mirror_photos(get_view(), create_thumbnail);
        
        init_page_context_menu("/TagsContextMenu");
    }
    
    ~TagPage() {
        get_view().halt_mirroring();
    }
    
    public Tag get_tag() {
        return tag;
    }
    
    protected override void get_config_photos_sort(out bool sort_order, out int sort_by) {
        Config.get_instance().get_library_photos_sort(out sort_order, out sort_by);
    }

    protected override void set_config_photos_sort(bool sort_order, int sort_by) {
        Config.get_instance().set_library_photos_sort(sort_order, sort_by);
    }
    
    private static Gtk.ActionEntry[] create_actions() {
        Gtk.ActionEntry[] actions = new Gtk.ActionEntry[0];
        
        Gtk.ActionEntry delete_tag = { "DeleteTag", null, TRANSLATABLE, null, null, on_delete_tag };
        delete_tag.label = Resources.DELETE_TAG_MENU;
        delete_tag.tooltip = Resources.DELETE_TAG_TOOLTIP;
        actions += delete_tag;
        
        return actions;
    }
    
    private void on_delete_tag() {
        get_command_manager().execute(new DeleteTagCommand(tag));
    }
}
