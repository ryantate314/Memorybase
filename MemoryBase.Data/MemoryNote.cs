//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MemoryBase.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class MemoryNote
    {
        public int MemoryNoteKey { get; set; }
        public int MemoryKey { get; set; }
        public string Text { get; set; }
        public System.DateTime DateAdded { get; set; }
        public sbyte Deleted { get; set; }
    
        public virtual Memory Memory { get; set; }
    }
}
