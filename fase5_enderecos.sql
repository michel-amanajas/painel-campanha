
-- ===== Fase 5: tabela de endereços de referência (municípios e comunidades do Amapá) =====
create table if not exists public.municipios_ap (
  nome text primary key,
  cep_padrao text not null
);
create table if not exists public.localidades (
  id bigserial primary key,
  municipio text not null references public.municipios_ap(nome),
  nome text not null,
  tipo text not null default 'comunidade',
  unique (municipio, nome)
);
alter table public.municipios_ap enable row level security;
alter table public.localidades enable row level security;
create policy municipios_ap_ler on public.municipios_ap for select to authenticated using (true);
create policy municipios_ap_gravar on public.municipios_ap for all to authenticated using (public.meu_papel() = 'administrador') with check (public.meu_papel() = 'administrador');
create policy localidades_ler on public.localidades for select to authenticated using (true);
create policy localidades_gravar on public.localidades for all to authenticated using (public.meu_papel() = 'administrador') with check (public.meu_papel() = 'administrador');
insert into public.municipios_ap (nome, cep_padrao) values
  ('Amapá', '68950-000'),
  ('Calçoene', '68960-000'),
  ('Cutias', '68973-000'),
  ('Ferreira Gomes', '68915-000'),
  ('Itaubal', '68976-000'),
  ('Laranjal do Jari', '68920-000'),
  ('Macapá', '68900-000'),
  ('Mazagão', '68940-000'),
  ('Oiapoque', '68980-000'),
  ('Pedra Branca do Amaparí', '68945-000'),
  ('Porto Grande', '68997-000'),
  ('Pracuúba', '68918-000'),
  ('Santana', '68925-000'),
  ('Serra do Navio', '68948-000'),
  ('Tartarugalzinho', '68990-000'),
  ('Vitória do Jari', '68924-000')
on conflict (nome) do update set cep_padrao = excluded.cep_padrao;
insert into public.localidades (municipio, nome) values
  ('Amapá', 'Sucuriju'),
  ('Amapá', 'Região dos Lagos'),
  ('Calçoene', 'Cunani'),
  ('Calçoene', 'Lourenço'),
  ('Calçoene', 'PDS Irineu e Felipe'),
  ('Cutias', 'Cutias do Araguari'),
  ('Ferreira Gomes', 'Igarapé do Palha'),
  ('Itaubal', 'Piririm'),
  ('Laranjal do Jari', 'São José'),
  ('Laranjal do Jari', 'São Francisco do Iratapuru'),
  ('Laranjal do Jari', 'PAE Maracá'),
  ('Laranjal do Jari', 'RESEX Rio Cajari'),
  ('Laranjal do Jari', 'Água Branca do Cajari'),
  ('Macapá', 'Bailique'),
  ('Macapá', 'Vila Progresso (Bailique)'),
  ('Macapá', 'Livramento (Bailique)'),
  ('Macapá', 'Macedônia (Bailique)'),
  ('Macapá', 'Arraiol (Bailique)'),
  ('Macapá', 'Brigue (Bailique)'),
  ('Macapá', 'Carapanatuba'),
  ('Macapá', 'São Joaquim do Pacuí'),
  ('Macapá', 'Curiaú'),
  ('Macapá', 'Conceição do Macacoari'),
  ('Macapá', 'Mel da Pedreira'),
  ('Macapá', 'Pedreira do Abacate'),
  ('Mazagão', 'Mazagão Velho'),
  ('Mazagão', 'Vila Nova'),
  ('Mazagão', 'Carvão'),
  ('Mazagão', 'Maracá'),
  ('Mazagão', 'RESEX Rio Cajari'),
  ('Oiapoque', 'Kumarumã'),
  ('Oiapoque', 'Kumenê'),
  ('Oiapoque', 'Manga'),
  ('Oiapoque', 'Espírito Santo'),
  ('Oiapoque', 'Mariry'),
  ('Oiapoque', 'Clevelândia do Norte'),
  ('Oiapoque', 'Vila Velha do Cassiporé'),
  ('Oiapoque', 'Kulumbu do Patuazinho'),
  ('Oiapoque', 'Vila Brasil'),
  ('Pedra Branca do Amaparí', 'Novo Canaã'),
  ('Santana', 'São Raimundo da Pirativa'),
  ('Santana', 'Ilha de Santana'),
  ('Tartarugalzinho', 'São Tomé do Aporema')
on conflict (municipio, nome) do nothing;
