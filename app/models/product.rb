class Product < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :sku, uniqueness: true
  belongs_to :user
  has_many :reviews
  has_many :order_products
  has_many :orders, through: :order_products

  has_attached_file :photo,
                    styles: {
                      medium: "300x300#", thumb: "100x100#" },
                      default_url: "/images/:style/missing.png",
                      :storage => :s3,
                      url: ":s3_domain_url",
                      path: "/:class/:attachment/:id_partition/:style/:filename",
                      s3_region: 'us-west-1',
                      :s3_credentials => Proc.new{|a| a.instance.s3_credentials
                    }

  def s3_credentials
    {
      :bucket => ENV["TRULY_LA_AWS_BUCKET_NAME"],
      :access_key_id => ENV["AWS_ACCESS_KEY_ID"],
      :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"]
    }
  end

  # makes sure that the only type of file being uploaded is an image:
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
