for app in */; do
  echo "Stowing $app..."
  stow -v -R -t ~ $app
done
