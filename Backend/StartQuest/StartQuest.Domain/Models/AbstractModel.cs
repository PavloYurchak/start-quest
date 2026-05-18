namespace StartQuest.Domain.Models
{
    public abstract record AbstractModel
    {
        public DateTime CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public bool IsActive { get; set; }
    }
}
