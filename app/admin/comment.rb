ActiveAdmin.register Comment do
  permit_params(:text, :user_id, :article_id)
end
